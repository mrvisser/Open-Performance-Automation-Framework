#!/usr/bin/env ruby

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"

# 
# == Synopsis
#
# Contacts class containing all operations around my contacts
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Memberships

  attr_accessor :session

  def initialize(session_obj)
    @session = session_obj
  end

  # Load my memberships
  def my_memberships(username, opts={})
  
  	defaults = {
  		:my_memberships_batch_requests => '%%_my_memberships_batch_requests%%',
  		:my_memberships_members_batch_requests => '%%_my_memberships_members_batch_requests%%'
  	}
  
  	opts = defaults.merge(opts)
  
    request = SessionUtil.new(@session).create_txn_reqs('my_memberships')
    
		request.add('/var/templates/worlds.2.json?_charset_=utf-8')
		request.add("/~#{username}/public/pubspace.infinity.json?_charset_=utf-8&_=1342719476262", {}, { 'subst' => 'true' })
		request.add("/~#{username}/private/privspace.infinity.json?_charset_=utf-8&_=1342719476434", {}, { 'subst' => 'true' })

		request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=#{opts[:my_memberships_batch_requests]}"
      }, { 'subst' => 'true' })

		request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=#{opts[:my_memberships_members_batch_requests]}"
      }, { 'subst' => 'true' })

  end

end
