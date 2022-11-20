# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module MouseMethods

  include LoggerEasy
  include CommonMethods

  def hover_to_element(element)
    @browser.action.move_to(element).perform
  end

  def move_to_element_and_click(element, x_coordinate = 0, y_coordinate = 0)
    @browser.action.move_to(element, x_coordinate, y_coordinate).click.perform
  end

  def move_by_and_click(x_coordinate = 0, y_coordinate = 0)
    @browser.action.move_by(x_coordinate, y_coordinate).click.perform
  end

  def move_by_and_scroll(selector, x_coordinate = 100, y_coordinate = 100, custom_timeout = nil)
    wait = Selenium::WebDriver::Wait.new(timeout: (custom_timeout.nil? ? LONGER_WAIT : custom_timeout))
    driver_temp = @browser
    element1 = wait.until { driver_temp.find_element(selector[0], selector[1]) }
    @browser.action.click_and_hold(element1).move_by(x_coordinate, y_coordinate).release.perform
  end

  def scroll_to_element_and_click(selector_or_element, x_coordinate = 0, y_coordinate = 300)
    10.times do
      element = selector_or_element.instance_of?(Selenium::WebDriver::Element) ? selector_or_element : get_element(selector_or_element)
      begin
        element.click
        break
      rescue
        page_scroll_down(1, x_coordinate, y_coordinate)
      end
    end
  end

  def element_drag_and_drop_by(element, x_offset = 100, y_offset = 100)
    @browser.action.drag_and_drop_by(element, x_offset, y_offset).perform
  end
end # MouseMethods
