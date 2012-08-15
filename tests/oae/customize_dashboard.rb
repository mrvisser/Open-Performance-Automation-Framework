#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and customize dashboard
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'customize_dashbaord', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

config.log.info_msg("#{test}: Loggin in as: #{username}")
Authentication.new(sesh).login(username, password)

# Customize Dashbaord work HERE

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout