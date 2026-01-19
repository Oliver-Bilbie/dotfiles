-- Some disgusting functions to compile and select binaries automatically

local function find_cargo_toml()
   local file = vim.fn.expand("%:p")
   local dir = vim.fn.fnamemodify(file, ":h")

   while dir ~= "/" do
      local candidate = dir .. "/Cargo.toml"
      if vim.fn.filereadable(candidate) == 1 then
         return candidate
      end
      dir = vim.fn.fnamemodify(dir, ":h")
   end

   return nil
end

local function rust_debug_main()
   local manifest = find_cargo_toml()
   if not manifest then
      error("No Cargo.toml found for current buffer")
   end

   manifest = vim.fn.fnamemodify(manifest, ":p")

   vim.cmd("silent !cargo build --manifest-path " .. manifest)

   local metadata = vim.fn.system("cargo metadata --format-version=1 --no-deps --manifest-path " .. manifest)
   local decoded = vim.json.decode(metadata)

   local package = nil
   for _, pkg in ipairs(decoded.packages) do
      if vim.fn.fnamemodify(pkg.manifest_path, ":p") == manifest then
         package = pkg
         break
      end
   end

   if not package then
      error("Cargo.toml does not correspond to a package")
   end

   for _, target in ipairs(package.targets) do
      if vim.tbl_contains(target.kind, "bin") then
         return decoded.target_directory .. "/debug/" .. target.name
      end
   end

   error("Cargo.toml has no binary targets.")
end

local function rust_debug_tests()
   local manifest = find_cargo_toml()
   if not manifest then
      error("No Cargo.toml found for current buffer")
   end

   manifest = vim.fn.fnamemodify(manifest, ":p")

   vim.cmd("silent !cargo test --no-run --manifest-path " .. manifest)

   local metadata = vim.fn.system("cargo metadata --format-version=1 --no-deps --manifest-path " .. manifest)
   local decoded = vim.json.decode(metadata)

   local package = nil
   for _, pkg in ipairs(decoded.packages) do
      if vim.fn.fnamemodify(pkg.manifest_path, ":p") == manifest then
         package = pkg
         break
      end
   end

   if not package then
      error("Could not match Cargo.toml to a package in metadata")
   end

   local crate = package.name
   local target_dir = decoded.target_directory

   local candidates = vim.fn.glob(
      target_dir .. "/debug/deps/" .. crate .. "-*",
      true,
      true
   )

   for _, path in ipairs(candidates) do
      if vim.fn.executable(path) == 1 then
         return path
      end
   end

   error("No test executable found for crate: " .. crate)
end


-- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb

local dap = require("dap")

dap.adapters["rust-gdb"] = {
   type = "executable",
   command = "rust-gdb",
   args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.rust = {
   {
      name = "Launch",
      type = "rust-gdb",
      request = "launch",
      program = rust_debug_main,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
   },
   {
      name = "Tests",
      type = "rust-gdb",
      request = "launch",
      program = rust_debug_tests,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
   },
}
