#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and upload several content types
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/library/content.rb"


# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'upload_content', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

config.log.info_msg("#{test}: Loggin in as: #{username}")
Authentication.new(sesh).login(username, password)
Dashboard.new(sesh).load(username)

sesh.add_thinktime(5)

# Upload Content
config.log.info_msg("#{test}: Uploading text")
Content.new(sesh).add(username)

sesh.add_thinktime(5)

# Logout
config.log.info_msg("#{test}: Logging out")
Authentication.new(sesh).logout
