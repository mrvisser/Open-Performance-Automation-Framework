#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and view my contacts
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/contacts.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'my_contacts', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

config.log.info_msg("#{test}: Loggin in as: #{username}")
Authentication.new(sesh).login(username, password)
Dashboard.new(sesh).load(username)

sesh.add_thinktime(3)

# view my contacts
config.log.info_msg("#{test}: Viewing My Contacts as: #{username}")
Contacts.new(sesh).my_contacts(username)

sesh.add_thinktime(5)

# Logout
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(sesh).logout
