local function fail(message)
  vim.api.nvim_err_writeln("Mason bootstrap failed: " .. message)
  vim.cmd("cquit 1")
end

local ok, lazy = pcall(require, "lazy")
if not ok then
  fail("lazy.nvim is not available; run Lazy sync first")
  return
end

-- Force LazyVim's Mason integrations to configure themselves in this
-- short-lived headless session. Their ensure_installed hooks use Mason's
-- registry asynchronously.
lazy.load({
  plugins = {
    "mason.nvim",
    "mason-lspconfig.nvim",
    "mason-nvim-dap.nvim",
    "nvim-lspconfig",
    "nvim-dap",
  },
  wait = true,
})

local registry_ok, registry = pcall(require, "mason-registry")
if not registry_ok then
  fail("mason-registry is not available")
  return
end

local failures = {}
registry:on("package:install:failed", function(package, error_message)
  failures[#failures + 1] = package.name .. ": " .. tostring(error_message)
end)

local refreshed = false
registry.refresh(function()
  refreshed = true
end)

local timeout_ms = 30 * 60 * 1000
local completed = vim.wait(timeout_ms, function()
  if not refreshed then
    return false
  end
  for _, package in ipairs(registry.get_all_packages()) do
    if package:is_installing() then
      return false
    end
  end
  return true
end, 100)

if not completed then
  fail("timed out waiting for package installations")
  return
end

if #failures > 0 then
  fail(table.concat(failures, "\n"))
  return
end

vim.cmd("qa")
