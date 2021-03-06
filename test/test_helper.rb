require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include Capybara::Assertions
end


def login(role = :editor)
  page.driver.submit :delete, destroy_user_session_path, {}
  visit new_user_session_path
  fill_in "Email", with: users(role).email
  fill_in "Password", with: "password"

  click_on "Sign in"
end

def post_comment(role = :editor)
  login(role)
  visit post_path(posts(:gangsta))
  fill_in "Comment", with: comments(:comment1).content

  # When I submit the form
  click_on "Submit Comment"
end

Turn.config.format = :outline
