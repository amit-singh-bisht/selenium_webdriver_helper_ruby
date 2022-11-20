# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module WindowMethods

  include LoggerEasy
  include CommonMethods

  def maximize_window(driver)
    block_execution do
      driver.manage.window.maximize
      log_info '[selenium webdriver helper] window is maximized successfully.'
    end # block_execution
  end # maximize_window

  def wait_for_new_window
    5.times do
      break if window_handles.size > 1

      sleep SHORTER_WAIT
    end
  end

  def window_handles
    @browser.window_handles
  end

  def switch_to_window(handle)
    @browser.switch_to.window handle
  end

  def window_width
    @browser.manage.window.size.width
  end

  def window_height
    @browser.manage.window.size.height
  end

  def resize_browser(height = 200, width = 200)
    @browser.manage.window.resize_to(width, height)
  end

  def new_window_visible?(window_handle_count)
    5.times do
      return true if window_handles.length > window_handle_count

      sleep SHORTER_WAIT
    end
    false
  end

  def close_current_window
    @browser.close
  end
end
