#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and view my memberships
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/memberships.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'my_memberships', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

config.log.info_msg("#{test}: Loggin in as: #{username}")
Authentication.new(sesh).login(username, password)
Dashboard.new(sesh).load(username)

sesh.add_thinktime(5)

# view my memberships
config.log.info_msg("#{test}: Viewing My Memberships as: #{username}")
Memberships.new(sesh).my_memberships(username)

sesh.add_thinktime(5)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
