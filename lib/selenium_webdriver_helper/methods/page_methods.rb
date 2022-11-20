# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module PageMethods

  include LoggerEasy
  include CommonMethods

  def wait_for_page_load(custom_timeout)
    block_execution do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { execute_script('return document.readyState;') == 'complete' }
      log_info "[selenium webdriver helper] page is loaded successfully i.e. document.readyState == 'complete'"
    end # block_execution
  end # wait_for_page_load

  def page_refresh(driver)
    driver.navigate.refresh
  end # page_refresh

  def page_refresh_js
    execute_script('location.reload(true);')
  end # page_refresh_js

  def page_title
    @browser.title
  end

  def page_url_scheme_https?
    current_page_url.include?('https')
  end

  def page_loaded?(url_path, retry_count = 5)
    count = 0
    while count < retry_count
      count += 1
      current_url = current_page_url
      state = execute_script('return document.readyState').eql?('complete')
      return true if state && !current_url.nil? && current_url.to_s.include?(url_path)

      sleep SHORTEST_WAIT
    end
    false
  end

  def wait_for_element_with_page_refresh(selector, visibility = true, retry_count = 3, wait_time = SHORT_WAIT)
    count = 0
    while count < retry_count
      count += 1
      page_refresh(driver)
      return true if element_displayed?(selector, true, wait_time) == visibility
    end
    raise "element visibility is not #{visibility} for #{selector}" unless element_displayed?(selector, true, wait_time) == visibility
  end

  def navigate_to_previous_page
    @browser.navigate.back
  end

  def hard_page_refresh
    @browser.execute_script('location.reload(true);')
  end
end
