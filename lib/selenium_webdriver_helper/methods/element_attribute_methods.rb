# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module ElementAttributeMethods

  include LoggerEasy
  include CommonMethods

  def element_attribute(element_or_selector, attribute)
    element = if !(element_or_selector.is_a?(Array) || element_or_selector.is_a?(Hash))
                element_or_selector
              else
                block_execution(3) do
                  get_element(element_or_selector, false)
                end
              end
    element.attribute(attribute)
  end

  def set_element_attribute(element, attribute_name, attribute_value)
    execute_script("arguments[0].setAttribute('#{attribute_name}', '#{attribute_value}')",element)
  end

  def element_style(element, style)
    element.style(style)
  end

end # ElementAttributeMethods
