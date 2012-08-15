#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and invite a contact
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/search.rb"
require config.lib_base_dir + "/#{config.product}/common/profile.rb"
require config.lib_base_dir + "/#{config.product}/common/contacts.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'invite_contact', probability)

# Navigate to the home page
config.log.info_msg("#{test}: Loading the home page")
explore = Explore.new(sesh).splash

sesh.add_thinktime(5)

# Login
inviter_username = '%%_invite_inviter_username%%'
inviter_password = '%%_invite_inviter_password%%'

# Who to invite
invitee_username = '%%_invite_invitee_username%%'
invitee_password = '%%_invite_invitee_password%%'

config.log.info_msg("#{test}: Logging in as: #{inviter_username}")
Authentication.new(sesh).login(inviter_username, inviter_password)

# Directly to dashboard with no thinktime
config.log.info_msg("#{test}: View my dashboard")
Dashboard.new(sesh).load(inviter_username)

sesh.add_thinktime(3)

# Search for the user to add, defaults to 'all' page
config.log.info_msg("#{test}: Searching for user #{invitee_username}")
Search.new(sesh).load
Search.new(sesh).search(invitee_username)

sesh.add_thinktime(3)

# Switch to user tab
Search.new(sesh).search(invitee_username, 'people')

sesh.add_thinktime(1)

# Click user
config.log.info_msg("#{test}: Viewing profile for #{invitee_username}")
Profile.new(sesh).view(invitee_username)

# Invite the invitee
config.log.info_msg("#{test}: Invite user #{invitee_username}")
Contacts.new(sesh).invite(inviter_username, invitee_username)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
