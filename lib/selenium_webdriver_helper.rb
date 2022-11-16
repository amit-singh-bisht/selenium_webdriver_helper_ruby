# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2022 amit-singh-bisht
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'selenium-webdriver'
require 'logger'
require_relative 'selenium_webdriver_helper/constants'

# below is the code to make life easier as it already has selenium webdriver methods defined
module SeleniumWebdriverHelper

  class Error < StandardError; end

  attr_accessor :driver

  def log_info(message)
    logger = Logger.new('selenium.log')
    logger.info(message)
  end

  def log_debug(message)
    logger = Logger.new('selenium.log')
    logger.debug(message)
  end

  def log_error(message)
    logger = Logger.new('selenium.log')
    logger.error(message)
  end

  def selectors_from_page_objects(page_object, value = nil)
    output = []
    if page_object.is_a?(Array)
      output << page_object.first
      output << page_object.last
    elsif page_object.is_a?(Hash)
      output = page_object.first
    elsif value.nil?
      raise "Locator cannot be nil - #{page_object} #{value}"
    end
    output
  end

  def block_execution(retry_count = 3, &block)
    block.call
  rescue Selenium::WebDriver::Error => e
    logger.info "#{e.message} \n #{e.backtrace}"
    retry_count -= 1
    retry if retry_count.positive?
  end

  def initialize_driver(driver, implicit_wait = LONGER_WAIT)
    $driver = driver
    $driver.manage.timeouts.implicit_wait = implicit_wait
    $wait = Selenium::WebDriver::Wait.new(timeout: implicit_wait) # seconds
  end

  def execute_script(js, *args)
    $driver.execute_script(js, *args)
  rescue Selenium::WebDriver::Error::UnsupportedOperationError => e
    log_error("[Exception] underlying webdriver instance does not support javascript #{e.message}")
  end

  def wait_for_page_load(custom_timeout = SHORTER_WAIT)
    wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
    wait.until { execute_script('return document.readyState;') == 'complete' }
  end

  def get_url(url, driver = $driver)
    driver.get(url)
    # wait_for_page_load
    log_info("visited #{url}")
  end

  def maximize_window(driver = $driver)
    driver.manage.window.maximize
    log_info('window maximized')
  end

  def save_screenshot(path, driver = $driver)
    driver.save_screenshot(path)
    log_info("screenshot captured and saved at path #{path}")
  end

  def get_element(selector, custom_timeout = LONGER_WAIT, driver = $driver)
    how, what = selectors_from_page_objects(selector)
    block_execution(3) do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      begin
        wait.until { driver.find_element(how, what).displayed? }
        driver.find_element(how, what)
      rescue Selenium::WebDriver::Error::NoSuchElementError => e
        raise "Exception #{e.message} \n #{e.backtrace}"
      end
    end
  end

  def get_elements(selector, custom_timeout = LONGER_WAIT, driver = $driver)
    how, what = selectors_from_page_objects(selector)
    block_execution(3) do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      begin
        wait.until { driver.find_elements(how, what)[0].displayed? }
        driver.find_elements(how, what)
      rescue Selenium::WebDriver::Error::NoSuchElementError => e
        raise "Exception #{e.message} \n #{e.backtrace}"
      end
    end
  end

  def element_text(selector, custom_timeout = LONGER_WAIT, driver = $driver)
    block_execution(3) do
      get_element(selector, custom_timeout, driver).text
    end
  end

  def find_element_and_send_keys(selector, value, driver = $driver)
    block_execution(3) do
      get_element(selector).send_keys(value)
    end
  end

  def element_click(selector, custom_timeout = LONGER_WAIT, driver = $driver)
    block_execution(3) do
      get_element(selector, custom_timeout, driver).click
    end
  end

  def element_displayed?(selector)
    element_list = get_elements(selector)
    element_list.each do |element|
      return element if element.displayed?
    end
    raise "No visible element found for selector - #{selector}"
  end

  def wait_for_element_visibility(selector_or_element, visibility = true, custom_timeout = LONG_WAIT)
    wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
    if !(selector_or_element.is_a?(Array) || selector_or_element.is_a?(Hash))
      wait.until { selector_or_element.displayed? == visibility }
    else
      wait.until { element_displayed?(selector_or_element) == visibility }
    end
  end

  def wait_for_element(selector, driver = $driver)
    how, what = selectors_from_page_objects(selector)
    5.times do
      driver.find_element(how, what)
      break
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      logger.info "[Exception] Retrying to find element due to exception #{e.message}"
    end
  end

  def get_child_element(parent_element, selector, custom_timeout = LONG_WAIT)
    how, what = selectors_from_page_objects(selector)
    block_execution(3) do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { parent_element.find_element(how, what).displayed? }
      parent_element.find_element(how, what)
    end
  end

  def get_child_elements(parent_element, selector, custom_timeout = LONG_WAIT)
    how, what = selectors_from_page_objects(selector)
    block_execution(3) do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { parent_element.find_elements(how, what)[0].displayed? }
      parent_element.find_elements(how, what)
    end
  end

  def page_refresh(driver = $driver)
    driver.navigate.refresh
  end

  def page_refresh_js
    execute_script('location.reload(true);')
  end

end
