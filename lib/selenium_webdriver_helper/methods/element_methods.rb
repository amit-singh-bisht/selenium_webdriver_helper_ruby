# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module ElementMethods

  include LoggerEasy
  include CommonMethods

  def get_element(selector, custom_timeout, driver)
    block_execution do
      @how, @what = selectors_from_page_objects(selector)
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { driver.find_element(@how, @what).displayed? }
      log_info "[selenium webdriver helper] element #{@what} using #{@how} was displayed within custom time #{custom_timeout} seconds."
      driver.find_element(@how, @what)
    end # block_execution
  end # get_element

  def element_text(selector, custom_timeout, driver)
    block_execution do
      element = get_element(selector, custom_timeout, driver)
      log_info "[selenium webdriver helper] was able to find element #{@what} using #{@how} within custom time #{custom_timeout} seconds."
      element.text
    end # block_execution
  end # element_text

  def find_element_and_send_keys(selector, value, custom_timeout, driver)
    block_execution do
      element = get_element(selector, custom_timeout, driver)
      log_info "[selenium webdriver helper] was able to find element #{@what} using #{@how} within custom time #{custom_timeout} seconds."
      element.send_keys(value)
    end # block_execution
  end # find_element_and_send_keys

  def element_click(selector, custom_timeout, driver)
    block_execution do
      element = get_element(selector, custom_timeout, driver)
      log_info "[selenium webdriver helper] was able to find element #{@what} using #{@how} within custom time #{custom_timeout} seconds."
      element.click
    end # block_execution
  end # element_click

  def element_click_js(selector, custom_timeout, driver)
    block_execution do
      if selector.instance_of?(Selenium::WebDriver::Element)
        execute_script('return arguments[0].click()', selector)
      elsif selector.instance_of?(String)
        execute_script("$(\"#{selector}\").click()")
      else
        element_click(selector, custom_timeout, driver)
      end
    end
  end

  def element_displayed?(selector, custom_timeout, driver)
    block_execution do
      elements = get_elements(selector, custom_timeout, driver)
      log_info "[selenium webdriver helper] was able to find multiple element(s) #{@what} using #{@how} within custom time #{custom_timeout} seconds."
      elements.length.zero ? false : true
    end # block_execution
  end # element_displayed?

  def element_displayed_js?(selector)
    block_execution do
      case selector
      when Array
        _how, what = selectors_from_page_objects(selector)
      when String
        what = selector
      end
      execute_script("return $(\"#{what}\").is(\":visible\")")
    end
  end

  def element_not_displayed_condition(using, locator)
    !@driver.find_element(using, locator).displayed?
  rescue Selenium::WebDriver::Error::NoSuchElementError
    true
  end

  def element_not_displayed?(selector, check_wait = true, custom_timeout = SHORTEST_WAIT)
    block_execution do
      how, what = selectors_from_page_objects(selector)
      if check_wait
        begin
          wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
          wait.until { element_not_displayed_condition(how, what) }
        rescue StandardError => e
          logger.info "Exception thrown for #{what} : #{e}"
          false
        end
      else
        element_not_displayed_condition(how, what)
      end
    end
  end

  def wait_for_element_visibility(selector, visibility, custom_timeout, driver)
    block_execution do
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { element_displayed?(selector, custom_timeout, driver) == visibility }
    end # block_execution
  end # wait_for_element_visibility

  def wait_for_element(selector, custom_timeout, driver)
    block_execution do
      how, what = selectors_from_page_objects(selector)
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { driver.find_element(how, what) }
    end # block_execution
  end # wait_for_element

  def get_child_element(parent_element, selector, custom_timeout)
    block_execution do
      how, what = selectors_from_page_objects(selector)
      wait = Selenium::WebDriver::Wait.new(timeout: custom_timeout)
      wait.until { parent_element.find_element(how, what).displayed? }
      parent_element.find_element(how, what)
    end # block_execution
  end # get_child_element

  def get_element_location(element)
    element.location
  end

  def element_value(selector_or_element)
    element_attribute(selector_or_element, 'value')
  end

  def element_from_element_or_selector(selector, custom_timeout, driver)
    if !(selector.is_a?(Array) || selector.is_a?(Hash))
      selector
    else
      get_element(selector, custom_timeout, driver)
    end
  end

  def get_element_height_and_width(element)
    height = element_attribute(element, 'height').to_i
    width = element_attribute(element, 'width').to_i
    [height, width]
  end

  def element_disabled?(element)
    element_attribute(element, 'class').include?('disabled') || element_attribute(element, 'disabled') == 'true'
  end

  def click_element_and_select_value(selector, custom_timeout, driver, dropdown_value_selector)
    element = get_element(selector, custom_timeout, driver)
    element.click
    sleep SHORTEST_WAIT
    element = get_element(dropdown_value_selector, custom_timeout, driver)
    element.click
  end

  def element_in_view?(selector)
    case selector[0]
    when :id
      execute_script("return isElementInView(document.getElementById('#{selector[0]}'))")
    when :css
      execute_script("return isElementInView(document.querySelector('#{selector[1]}'))")
    end
  end
end
