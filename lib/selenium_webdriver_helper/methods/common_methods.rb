# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'

# below is the code to make life easier as it already has common selenium webdriver methods defined
module CommonMethods

  include LoggerEasy

  def block_execution(retry_count = 3, &block)
    block.call
  rescue => e
    retry_count -= 1
    retry if retry_count.positive?
    log_error "[selenium webdriver helper] ERROR : #{e.inspect} - #{e.message}\n#{e.backtrace}"
    raise "[selenium webdriver helper] ERROR : #{e.inspect} - #{e.message}\n#{e.backtrace}"
  end # block_execution

  def selectors_from_page_objects(page_object, value = nil)
    block_execution(1) do
      output = []
      if page_object.is_a?(Array)
        output << page_object.first
        output << page_object.last
      elsif page_object.is_a?(Hash)
        output = page_object.first
      elsif value.nil?
        raise "[selenium webdriver helper] Locator cannot be nil - #{page_object} #{value}" if value.nil?

        output << page_object
        output << value
      end # if-else condition
      log_info "[selenium webdriver helper] how, what: #{output}"
      output
    end # block_execution
  end # selectors_from_page_objects
end # CommonMethods
