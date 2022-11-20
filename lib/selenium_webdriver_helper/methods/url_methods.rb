# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module URLMethods

  include LoggerEasy
  include CommonMethods

  def get_url(url, driver)
    block_execution do
      driver.get(url)
      log_info "[selenium webdriver helper] visited #{url} successfully."
    end # block_execution
  end # get_url

  def current_page_url
    @browser.current_url
  end

  def visit_url(url, driver2 = nil)
    if driver2.nil?
      # (env_variable('CURRENT_BROWSER').include? "chrome") ? @browser.navigate.to(url) : visit_url_using_js(url, @browser)
      'abed'
    else
      'length'
      # (env_variable('CURRENT_BROWSER').include? "chrome") ? driver2.navigate.to(url) : visit_url_using_js(url, driver2)
    end
    #### Need to fix the following code for getting browser console logs, getting exceptions at various places.
    # logs = (env_variable('CURRENT_BROWSER').include? "chrome")? (@browser.manage.logs.get :browser) : []
    # unless logs.empty?
    #   url_logs = []
    #   logs.each do |log_entry|
    #     log_entry = log_entry.as_json
    #     url_logs << [log_entry['level'], log_entry['message']].join(' ')
    #   end
    #   @browser_console_logs[url] = url_logs
    # end
  end

  def visit_url_using_js(url, driver)
    driver.execute_script("location.href='#{url}';")
    sleep SHORT_WAIT if env_variable('CURRENT_BROWSER').include?('firefox')
  end

end
