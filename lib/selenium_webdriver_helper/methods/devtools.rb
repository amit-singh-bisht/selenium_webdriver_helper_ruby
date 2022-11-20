# frozen_string_literal: true

require 'logger_easy'
require 'selenium-webdriver'
require_relative 'common_methods'

# below is the code to make life easier as it already has selenium webdriver methods defined
module DevToolsMethods

  include LoggerEasy
  include CommonMethods

  def send_devtools_cmd(driver, cmd, params = {})
    bridge = driver.send(:bridge)
    resource = "session/#{bridge.session_id}/chromium/send_command_and_get_result"
    response = bridge.http.call(:post, resource, { 'cmd': cmd, 'params': params })
    raise response[:value] if response[:status]

    logger.info("send_devtools_cmd - #{cmd} -#{response[:value]}")
    response[:value]
  end

  def throttle_network(network_conditions)
    send_devtools_cmd(@browser, 'Network.emulateNetworkConditions', network_conditions)
  end

end # DevToolsMethods
