require_relative '../config/application.rb'

# Setting up/formatting Rspec with a few optional paramaters
# So that we can effectively run our tests

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.color_enabled = true
  config.formatter = :documentation
  config.order = 'random'
end
