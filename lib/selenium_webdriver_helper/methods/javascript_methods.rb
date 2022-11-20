# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module JavascriptMethods

  include LoggerEasy
  include CommonMethods

  def execute_script(javascript, *args)
    block_execution do
      @driver.execute_script(javascript, *args)
      log_info "[selenium webdriver helper] executed script: #{javascript} successfully."
    end # block_execution
  end # execute_script

  def window_scroll_x
    execute_script('return window.scrollX')
  end

  def window_scroll_y
    execute_script('return window.scrollY')
  end

  def scroll_to(selector, x_coordinate = 0, y_coordinate = 0)
    element = get_element(selector)
    @browser.execute_script("arguments[0].scrollTo(#{x_coordinate},#{y_coordinate});", element)
  end

  def scroll_to_top
    wait_for_page_load
    @browser.execute_script('$(document).scrollTop(0);')
  end

  def page_scroll_down(count = 2, x = 0, y = 600)
    count.times do
      @browser.execute_script("window.scrollBy(#{x},#{y})", '')
      sleep SHORTEST_WAIT
    end
  end

  def console_logs
    @browser.manage.logs.get(:browser)
  end

  def location_hash
    @browser.execute_script('return window.location.hash')
  end
end
