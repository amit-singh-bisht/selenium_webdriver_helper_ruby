# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module IFrameMethods

  include LoggerEasy
  include CommonMethods

  def switch_frame(frame_id, retry_count = 5)
    i = 0
    while i < retry_count
      begin
        @browser.switch_to.frame(frame_id)
        break
      rescue Exception => e
        logger.info e.message
        sleep SHORT_WAIT
        i += 1
      end
    end
  end

  def switch_to_default
    @browser.switch_to.default_content
  end
  
end # IFrameMethods
