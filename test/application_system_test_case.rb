# require "test_helper"

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
# end

# test/application_system_test_case.rb
require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver(:headless_chrome) do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome \
      chromeOptions: { args: %w[headless disable-gpu window-size=1280x760] }
    Capybara::Selenium::Driver.new app,
      browser: :chrome, desired_capabilities: capabilities
  end
  driven_by :headless_chrome

  class GamesTest < ApplicationSystemTestCase
    test "Going to /new gives us a new random grid to play with" do
      visit new_url
      assert test: "New game"
      assert_selector ".letter", count: 10
    end

  #   test "Word submitted is not in the grid" do
  #     visit score_url
  #     click_on "Have another go?"
  #     fill_in "Word", with: "Creating a Word"
  #     click_on "Play"
  #     assert_text "Creating a Play"
  #   end
  end
end
