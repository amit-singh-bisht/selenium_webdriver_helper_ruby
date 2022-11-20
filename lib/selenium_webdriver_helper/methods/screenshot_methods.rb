# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module ScreenshotMethods

  include LoggerEasy
  include CommonMethods

  def save_screenshot(path, driver)
    block_execution do
      driver.save_screenshot(path)
      log_info "[selenium webdriver helper] screenshot captured and saved at path #{path}."
    end # block_execution
  end # save_screenshot

  def get_image_natural_width(img_element)
    execute_script('return arguments[0].naturalWidth', img_element)
  end

end
