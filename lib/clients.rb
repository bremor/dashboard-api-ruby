# frozen_string_literal: true

# Clients section of the Meraki Dashboard API
# @author Joe Letizia, Shane Short
module Clients
  # Return client usage for a specific device
  # @param [String] serial meraki serial number of the device
  # @param [Integer] timespan timespan up to 1 month in seconds to get client usage for
  # @return [Array] an array of hashes for each client's usage
  def get_client_info_for_device(serial, timespan)
    raise 'Timespan can not be larger than 2592000 seconds' if timespan.to_i > 2_592_000

    make_api_call("/devices/#{serial}/clients?timespan=#{timespan}", :get)
  end

  # Return an array of connected clients in the target network
  # @param [String] network_id the network UUID for the target network
  # @param [Hash] options hash containing the attributes you want to modify.
  #   such as mac, vlan, ip, perPage. A full list is found on the official Meraki API Docs
  # @return [Array] an array of hashes with each client in the network
  def list_clients_in_network(network_id, options: {})
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)
    
    make_api_call(("/networks/#{network_id}/clients"), :get, , options)
  end

end
