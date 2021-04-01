ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include Warden::Test::Helpers
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  #Minitest.load_plugins
  #Minitest::PrideIO.pride!

  def create_user
    user = User.create!(name: 'Fulano de Tal', email: 'fulano@iugu.com.br', password: '123456')
    user
  end

  def create_another_user
    user = User.create!(name: 'Beltrano de Tal', email: 'beltrano@iugu.com.br', password: '123456')
    user
  end

end
