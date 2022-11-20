# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module ParentMethods

  include LoggerEasy
  include CommonMethods

  def get_parent_element_xpath(selector)
    how, what = selectors_from_page_objects(selector)
    selector = [:xpath, "#{what}/.."] if (how.eql? :xpath) || (how.eql? 'xpath')
    log_info "[selenium webdriver helper] parent element of #{what} is #{selector.last}"
    selector
  end

  def get_grandparent_element_xpath(selector)
    get_parent_element_xpath(get_parent_element_xpath(selector))
  end

end
