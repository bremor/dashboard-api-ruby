# frozen_string_literal: true

# Organization section of the Meraki Dashboard API
# @author Joe Letizia, Shane Short
module Organizations
  # Returns information about an organization
  # @param [String] org_id dashboard organization ID
  # @return [Hash] results contains the org  id and name of the given organization
  def get_organization(org_id)
    make_api_call("/organizations/#{org_id}", :get)
  end

  # Returns the current license state for a given organization
  # @param [String] org_id dashboard organization ID
  # @return [Hash] results contains the current license state information
  # @deprecated Use #get_license_overview instead
  def get_license_state(org_id)
    get_license_overview org_id
  end

  # Returns the current license state for a given organization
  # @param [String] org_id dashboard organization ID
  # @return [Hash] results contains the current license state information
  def get_license_overview(org_id)
    make_api_call("/organizations/#{org_id}/licenses/overview", :get)
  end

  # Returns the current inventory for an organization
  # @param [String] org_id dashboard organization ID
  # @return [Array] an array of hashes containg information on each individual device
  # @deprecated use #get_inventory_devices instead
  def get_inventory(org_id)
    get_inventory_devices org_id
  end

  # Returns the current inventory for an organization
  # @param [String] org_id dashboard organization ID
  # @return [Array] an array of hashes containg information on each individual device
  def get_inventory_devices(org_id)
    make_api_call("/organizations/#{org_id}/inventory/devices", :get)
  end

  # Returns the current SNMP status for an organization
  # @param [String] org_id dashboard organization ID
  # @return [Hash] a hash containing all SNMP configuration information for an organization
  def get_snmp_settings(org_id)
    make_api_call("/organizations/#{org_id}/snmp", :get)
  end

  # Updates the current SNMP status for an organization
  # @param [String] org_id dashboard organization ID
  # @param [Hash] options a hash containing all updated SNMP configuration information for an organization. Please
  #   refer to official Dashboard API documentation for more information on these options: v2cEnabled, v3Enabled,
  #   v3AuthMode, v3AuthPass, v3PrivMode, v3PrivPass, peerIps
  # @return [Hash] a hash containing all SNMP configuration information for an organization
  def update_snmp_settings(org_id, options)
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)

    make_api_call("/organizations/#{org_id}/snmp", :put, options)
  end

  # Returns the configurations for an organizations 3rd party VPN peers
  # @param [String] org_id dashboard organization ID
  # @return [Array] an arrry of hashes containing the configuration information
  #   for each 3rd party VPN peer
  def get_third_party_vpn_peers(org_id)
    make_api_call("/organizations/#{org_id}/thirdPartyVPNPeers", :get)
  end

  # Updates your third party VPN peers
  # @param [String] org_id dashboard organization ID
  # @param [Hash] options: a hash with a key of 'Peers' containing an array
  #               of Hashes representing all configured third party peer.
  #               Takes the keys of name, publicIp, privateSubnets and secret
  # @return [Array] returns the array of hashes for all currently configured 3rd party peers
  def update_third_party_vpn_peers(org_id, options)
    raise 'Options were not passed as an Hash' unless options.is_a?(Hash)
    raise "Key '[peers]' is missing from supplied options" unless options['peers']

    make_api_call("/organizations/#{org_id}/appliance/vpn/thirdPartyVPNPeers", :put, options)
  end

  # Returns the configurations for an organizations 3rd party VPN peers
  # @param [String] org_id dashboard organization ID
  # @return [Array] an arrry of hashes containing the configuration information
  #   for each 3rd party VPN peer
  # @deprecated use #get_third_party_vpn_peers instead
  def get_third_party_peers(org_id)
    get_third_party_vpn_peers org_id
  end

  # Updates your third party peers
  # @param [String] org_id dashboard organization ID
  # @param [Array] options An array of Hashes representing all configured third party peer. Takes the keys of name,
  #   publicIp, privateSubnets and secret
  # @return [Array] returns the array of hashes for all currently configured 3rd party peers
  # @deprecated use #update_third_party_vpn_peers instead
  def update_third_party_peers(org_id, options)
    raise 'Options were not passed as an Array' unless options.is_a?(Array)

    update_third_party_vpn_peers(org_id, { 'peers' => options })
  end

  # Returns all organizations a user is an administrator on
  # @return [Array] an array of hashes containing the organizations and their attributes
  def list_all_organizations
    make_api_call('/organizations', :get)
  end

  # Update an organization
  # @param [String] org_id the organization ID that you want to update
  # @param [Hash] options an options hash containing the org ID and new name of the org
  # @return [Hash] the updated attributes of the organization
  def update_organization(org_id, options)
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)

    make_api_call("/organizations/#{org_id}", :put, options)
  end

  # Create a new organization
  # @param [Hash] options an options hash containing the name of the new organization
  # @return [Hash] the attributes of the newly created organization
  def create_organization(options)
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)

    make_api_call('/organizations', :post, options)
  end

  # Clone an organization
  # @param [String] source_org_id the source organization that we want to clone from
  # @param [Hash] options options hash containing the attributes for the new organization
  # @return [Hash] the attributes of the newly cloned organization
  def clone_organization(source_org_id, options)
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)

    make_api_call("/organizations/#{source_org_id}/clone", :post, options)
  end

  # Claim something
  # @param [String] org_id the organization that you want to claim to
  # @param [Hash] options a hash containing information about what you want to claim. This can be order,
  #   serial, licenseKey and licenseMode. Refer to the official Dashboard API documentation for more information
  #   about these
  # @return [Integer] HTTP Code
  def claim(org_id, options)
    raise 'Options were not passed as a Hash' unless options.is_a?(Hash)

    make_api_call("/organizations/#{org_id}/claim", :post, options)
  end
end