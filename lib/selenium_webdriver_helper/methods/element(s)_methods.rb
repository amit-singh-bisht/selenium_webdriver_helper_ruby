# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module ElementsMethods

  include LoggerEasy
  include CommonMethods

  def get_elements(selector, custom_timeout, driver)
    block_execution do
      how, what = selectors_from_page_objects(selector)
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { driver.find_elements(how, what)[0].displayed? }
      log_info "[selenium webdriver helper] multiple element(s) #{what} using #{how} was displayed within custom time #{custom_timeout} seconds."
      driver.find_elements(how, what)
    end # block_execution
  end # get_elements

  def number_of_elements_displayed(selector, custom_timeout, driver)
    block_execution do
      elements = get_elements(selector, custom_timeout, driver)
      log_info "[selenium webdriver helper] was able to find multiple element(s) #{@what} using #{@how} within custom time #{custom_timeout} seconds."
      elements.length
    end # block_execution
  end

  def get_child_elements(parent_element, selector, custom_timeout)
    block_execution do
      how, what = selectors_from_page_objects(selector)
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { parent_element.find_elements(how, what)[0].displayed? }
      parent_element.find_elements(how, what)
    end # block_execution
  end # get_child_elements

  def get_elements_text_list(selector, custom_timeout, driver)
    element_list = get_elements(selector, custom_timeout, driver)
    element_text_list = []
    element_list.each_with_index { |_element,index|
      element_text_list[index] = element_list[index].text.strip
    }
    element_text_list
  end
end
