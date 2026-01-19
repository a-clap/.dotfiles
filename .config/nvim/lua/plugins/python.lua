return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          dap = { justMyCode = false },
          args = { "-vv", "--capture=tee-sys", "--log-level=DEBUG", "-s" },
          pytest_discover_instances = true,
        },
      },
    },
  },
}
