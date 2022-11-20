# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module KeyboardsMethods

  include LoggerEasy
  include CommonMethods

  def press_keys(keys, element = nil)
    begin
      if element.nil?
        keys.split("").each do |key|
          @browser.action.send_keys(key).perform
          sleep SUPER_ULTRA_SHORT_WAIT
        end
      else
        @browser.action.send_keys(element, key).perform
      end
    rescue Exception => e
      @browser.action.send_keys(keys).perform
      sleep SHORT_WAIT
    end
  end

  def select_all_using_keyboard(key = :control)
    key_down(key)
    press_keys('a')
    key_up(key)
  end

  def paste_using_keyboard(key = :control)
    key_down(key)
    press_keys('v')
    key_up(key)
  end

  def key_up(key)
    @browser.action.key_up(key.to_sym).perform
  end

  def key_down(key)
    @browser.action.key_down(key.to_sym).perform
  end

  def clear_text_field(element_or_selector, clear = true)
    element = element_from_element_or_selector(element_or_selector)
    element.clear if clear
    element
  end

  def send_keys(element_or_selector, value, clear = true)
    element = clear_text_field element_or_selector, clear
    element.send_keys(value)
  end

  def send_keys_js(element, value, clear = true)
    element.clear if clear
    execute_script("arguments[0].value = '#{value}'", element)
  end

  def select_from_dropdown(selector, select_by, option)
    drop_down_menu = get_element(selector)
    options = Selenium::WebDriver::Support::Select.new(drop_down_menu)
    options.select_by(select_by, option)
  end

  def scroll_up_till_element_visible(using)
    5.times do
      scroll_up unless element_displayed?(using)
    end
  end

  def scroll_up
    5.times do
      press_keys(:arrow_up)
    end
  end

  def send_keys_for_ie(selector, value)
    if selector[0].eql?(:id)
      execute_script("document.getElementById('#{selector[1]}').value = '#{value}'")
    elsif selector[0].eql?(:css)
      execute_script("document.querySelector('#{selector[1]}').value = '#{value}'")
    end
  end
end # KeyboardsMethods
