require 'rails_helper'
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.after(:each) do
    DatabaseRewinder.clean
  end
end
