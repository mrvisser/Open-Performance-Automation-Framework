#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and perform a general search
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/search.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'general_search', probability)

# Search term
search_term = 'ere'

# Navigate to the home page
config.log.info_msg("#{test}: Loading the home page")
Explore.new(sesh).splash

sesh.add_thinktime(5)

# Type search into top bar and hit enter
config.log.info_msg("#{test}: Searching for #{search_term}")
Search.new(sesh).load
Search.new(sesh).search(search_term)

# Switch context to the "Content" search
config.log.info_msg("#{test}: Switching context to Content search")
Search.new(sesh).search(search_term, 'content')