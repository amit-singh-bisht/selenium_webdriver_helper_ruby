# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module CheckboxMethods

  include LoggerEasy
  include CommonMethods

  def checkbox_selected?(element)
    element.selected?
  end

  def click_checkbox(selector)
    checkbox = get_element(selector)
    element_click(checkbox)
  end

  def uncheck_checkbox(element)
    if checkbox_selected?(element)
      element_click(element)
    end
  end

end # CheckboxMethods
