# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module TabMethods

  include LoggerEasy
  include CommonMethods

  def visit_url_in_new_tab(url)
    new_tab
    @browser.navigate.to url
  end

  def new_tab(action = 'open') ## If users wants to close tab, give "close" in argument instead of "open"
    @browser.execute_script("window.#{action}()")
    retry_count = 2
    begin
      switch_to_window(@browser.window_handles.last)
    rescue
      logger.info '[Window Handles]'
      retry_count -= 1
      retry if retry_count.positive?
      switch_to_window(@browser.window_handles.first)
    end
  end

  def open_link_in_new_tab(key,element)
    @browser.action.move_to(element).key_down(key.to_sym).click.perform
  end
end # TabMethods
