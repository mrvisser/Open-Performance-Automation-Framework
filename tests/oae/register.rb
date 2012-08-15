#!/usr/bin/env ruby

#
# == Description
#
# Register a new user on OAE
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/register.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'register', probability)

# Register
username = 'load_user_%%ts_user_server:get_unique_id%%' #unique id

config.log.info_msg("#{test}: Viewing the splash page")
Explore.new(sesh).splash

config.log.info_msg("#{test}: Registering as: #{username}")
Registration.new(sesh).load
Registration.new(sesh).type_username(username)
Registration.new(sesh).register(username)
sesh.add_thinktime(1)
Dashboard.new(sesh).load(username)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
