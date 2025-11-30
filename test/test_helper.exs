ExUnit.start()

# Configure ExUnit
ExUnit.configure(
  # Exclude tests tagged with :skip by default
  exclude: [skip: true],
  # Show test times for slow tests
  trace: false,
  # Maximum number of failures before stopping
  max_failures: :infinity
)
