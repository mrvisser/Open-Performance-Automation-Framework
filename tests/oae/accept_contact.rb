#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and accept a pending contact
#
# == Prerequisites
#
# This needs to know preloaded with some known pending contact invitations in the data-set.
# There should be a CSV file that provides the following variables:
#
# * _accept_inviter_username: The username of the user to initiated the contact request
# * _accept_invitee_username: The username of the user who will accept the contact request
# * _accept_invitee_password: The password of the user who will accept the contact request
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/messages.rb"
require config.lib_base_dir + "/#{config.product}/common/contacts.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Login User
invitee_username = '%%_accept_invitee_username%%'
invitee_password = '%%_accept_invitee_password%%'

# Whose contact request to accept
inviter_username = '%%_accept_inviter_username%%'

# Create session
sesh = Session.new(config, 'accept_contact', probability)

# Navigate to the home page
config.log.info_msg("#{test}: Loading the home page")
Explore.new(sesh).splash
Explore.new(sesh).splash
Explore.new(sesh).splash
sesh.add_thinktime(5)

config.log.info_msg("#{test}: Logging in, redirect to dashboard")
Authentication.new(sesh).login(invitee_username, invitee_password)
Dashboard.new(sesh).load(invitee_username)

sesh.add_thinktime(3)

# View my messages
config.log.info_msg("#{test}: Viewing My Messages as: #{invitee_username}")
Messages.new(sesh).my_inbox(invitee_username)

sesh.add_thinktime(5)

# Accept the invitation
config.log.info_msg("#{test}: Accept contact request from #{inviter_username} to #{invitee_username}")
Contacts.new(sesh).accept(inviter_username, invitee_username)

sesh.add_thinktime(3)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
