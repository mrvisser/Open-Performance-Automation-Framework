#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and customize profile
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/profile.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'customize_profile', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

# Data
new_first_name = '%%_rnd_first_name%%'
new_last_name = '%%_rnd_last_name%%'
tag_name = '%%_rnd_tag%%'

# Navigate to the home page
config.log.info_msg("#{test}: Loading the home page")
Explore.new(sesh).splash

sesh.add_thinktime(5)

config.log.info_msg("#{test}: Logging in as: #{username}")
user_data = Authentication.new(sesh).login(username, password)

# Directly to dashboard with no thinktime
config.log.info_msg("#{test}: View my dashboard")
Dashboard.new(sesh).load(username)

sesh.add_thinktime(3)

# Customize Profile
config.log.info_msg("#{test}: Customizing profile")
Profile.new(sesh).update_basic_information(username, new_first_name, new_last_name, user_data[:email], [tag_name])

sesh.add_thinktime(5)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
