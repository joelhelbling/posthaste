require 'bundler/setup'
require 'rspec/given'
require 'fakefs/spec_helpers'
require 'posthaste'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # use a fake filesystem when the :fakefs tag is used
  config.include FakeFS::SpecHelpers, fakefs: true
end
