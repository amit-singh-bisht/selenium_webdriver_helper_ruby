# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'constants'
require_relative 'methods/common_methods'
require_relative 'methods/javascript_methods'
require_relative 'methods/page_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
class SeleniumWebdriverHelperClass

  include LoggerEasy
  include CommonMethods

  def initialize(driver, implicit_wait, log_file_name)
    logger_easy(log_file_name)
    driver.manage.timeouts.implicit_wait = implicit_wait
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: implicit_wait) # seconds
  end # initialize

end # SeleniumWebdriverHelperClass
