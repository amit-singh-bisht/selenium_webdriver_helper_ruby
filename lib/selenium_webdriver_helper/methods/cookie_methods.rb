# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module CookieMethods

  include LoggerEasy
  include CommonMethods

  def add_cookie(name, value, opts = {})
    cookie = {
      name: name,
      value: value
    }
    cookie[:secure] = opts[:secure] if opts[:secure]
    cookie[:path] = opts[:path] if opts[:path]
    cookie[:expires] = opts[:expires] if opts[:expires]
    cookie[:domain] = opts[:domain] if opts[:domain]
    @browser.manage.add_cookie cookie
  end

  def delete_all_cookies
    @browser.manage.delete_all_cookies
  end

  def cookie_data(cookie_name = nil)
    value = nil
    @browser.manage.all_cookies.each do |cookie|
      value = cookie[:value] if cookie_name.include? cookie[:name].to_s
    end
    value
  end

  def set_cookie_value(cookie_name, cookie_value)
    raise 'Cookie Not Found' if cookie_data(cookie_name).nil?

    @browser.manage.delete_cookie(cookie_name)
    add_cookie(cookie_name, cookie_value) # Add as third argument for local as { domain: 'bsstag.com' })
    page_refresh
    raise 'Cookie is not changed for given experiment' unless cookie_data(cookie_name).eql?(cookie_value)
  end
end # CookieMethods
