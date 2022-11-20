# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module AlertMethods

  include LoggerEasy
  include CommonMethods

  def accept_alert
    @browser.switch_to.alert.accept if alert_exist?
  end

  def dismiss_alert
    @browser.switch_to.alert.dismiss if alert_exist?
  end

  def alert_text
    return @browser.switch_to.alert.text if alert_exist?
  end

  def alert_exist?
    @browser.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    false
  rescue Exception => e
    raise "Error occurred in alert_exist? - #{e}"
  end

  def wait_for_alert
    5.times do
      break if alert_exist?

      sleep SHORTER_WAIT
    end
  end

end # AlertMethods
