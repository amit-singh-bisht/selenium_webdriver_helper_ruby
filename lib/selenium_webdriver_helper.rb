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
require_relative 'selenium_webdriver_helper/selenium_webdriver_helper_class'
require_relative 'selenium_webdriver_helper/constants'

# below is the code to make life easier as it already has selenium webdriver methods defined
module SeleniumWebdriverHelper
  def selenium_webdriver_helper(driver, implicit_wait = LONGER_WAIT, log_file_name = 'selenium.log')
    @driver = driver
    @implicit_wait = implicit_wait
    @log_file_name = log_file_name
    @selenium_webdriver_helper = SeleniumWebdriverHelperClass.new(driver, implicit_wait, log_file_name)
  end # initialize_selenium_webdriver

  def execute_script(javascript, *args)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.execute_script(javascript, *args)
  end # execute_script

  def wait_for_page_load(custom_timeout = LONGER_WAIT)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.wait_for_page_load(custom_timeout)
  end # wait_for_page_load

  def get_url(url, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.get_url(url, driver)
  end # get_url

  def maximize_window(driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.maximize_window(driver)
  end # maximize_window

  def save_screenshot(path, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.save_screenshot(path, driver)
  end # save_screenshot

  def page_refresh(driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.page_refresh(driver)
  end # page_refresh

  def page_refresh_js
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.page_refresh_js
  end # get_child_elements

  def get_element(selector, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.get_element(selector, custom_timeout, driver)
  end # get_element

  def get_elements(selector, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.get_elements(selector, custom_timeout, driver)
  end # get_elements

  def element_text(selector, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.element_text(selector, custom_timeout, driver)
  end # element_text

  def find_element_and_send_keys(selector, value, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.find_element_and_send_keys(selector, value, custom_timeout, driver)
  end # find_element_and_send_keys

  def element_click(selector, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.element_click(selector, custom_timeout, driver)
  end # element_click

  def element_displayed?(selector, custom_timeout = LONGER_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.element_displayed?(selector, custom_timeout, driver)
  end # element_displayed?

  def wait_for_element_visibility(selector, visibility = true, custom_timeout = LONG_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.wait_for_element_visibility(selector, visibility, custom_timeout, driver)
  end # wait_for_element_visibility

  def wait_for_element(selector, custom_timeout = LONG_WAIT, driver = @driver)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.wait_for_element(selector, custom_timeout, driver)
  end # wait_for_element

  def get_child_element(parent_element, selector, custom_timeout = LONG_WAIT)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.get_child_element(parent_element, selector, custom_timeout)
  end # get_child_element

  def get_child_elements(parent_element, selector, custom_timeout = LONG_WAIT)
    @selenium_webdriver_helper ||= SeleniumWebdriverHelperClass.new(@driver, @implicit_wait, @log_file_name)
    @selenium_webdriver_helper.get_child_elements(parent_element, selector, custom_timeout)
  end # get_child_elements


end # SeleniumWebdriverHelper
