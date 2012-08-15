#!/usr/bin/env ruby

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"

# 
# == Synopsis
#
# Profile class containing all operations around profile functionality
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

require 'uri'

class Profile
  
  attr_accessor :session
  
  def initialize(session_obj)
    @session = session_obj
  end

  # View the user's profile
  def view(username)
    request = SessionUtil.new(@session).create_txn_reqs('profile_view')
		request.add("/~#{username}", {}, { 'subst' => 'true' })
		request.add('/var/widgets.json?callback=define')
		request.add('/system/me?_charset_=utf-8')
		request.add("/~#{username}/public/authprofile.profile.json?_charset_=utf-8&_=1342701233567", {}, { 'subst' => 'true' })
		request.add('/var/templates/worlds.2.json?_charset_=utf-8')
		request.add('/var/contacts/find-all.json?page=0&items=100&_charset_=utf-8')
		request.add("/~#{username}/public/pubspace.infinity.json?_charset_=utf-8&_=1342701234350", {}, { 'subst' => 'true' })
		request.add("/~#{username}/public/authprofile.profile.json?_charset_=utf-8&_=1342701234842", {}, { 'subst' => 'true' })
  end
    
  # Edit profile
  # username, first_name, last_name, and email should all be dynamic variables
  def update_basic_information(username, first_name, last_name, email, tags)
    request = SessionUtil.new(@session).create_txn_reqs('profile_update_basic_info')
    
    # Substitute @ for url encode
    email.sub!(/\@/, '%40')

    if (tags)
      # Editing tags
      # Bug only support 1 right now
      request.add("/~#{username}/public/authprofile",
        {
          'method' => 'POST',
          'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
          'contents' => "key=%2Ftags%2F#{tags.first}&%3Aoperation=tag&_charset_=utf-8"
        }, {'subst' => 'true'})
    end
    
    request.add("/~#{username}/public/authprofile/basic.profile.json",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3AremoveTree=true&%3Acontent=%7B%22access%22%3A%22everybody%22%2C%22elements%22%3A%7B%22lastName%22%3A%7B%22value%22%3A%22#{last_name}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{email}%22%7D%2C%22firstName%22%3A%7B%22value%22%3A%22#{first_name}%22%7D%2C%22preferredName%22%3A%7B%22value%22%3A%22%22%7D%7D%7D"
      }, {'subst' => 'true'})
    
    request.add("/~#{username}/public/authprofile/userprogress",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3AremoveTree=true&%3Acontent=%7B%22access%22%3A%22everybody%22%2C%22elements%22%3A%7B%22lastName%22%3A%7B%22value%22%3A%22#{last_name}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{email}%22%7D%2C%22firstName%22%3A%7B%22value%22%3A%22#{first_name}%22%7D%2C%22preferredName%22%3A%7B%22value%22%3A%22%22%7D%7D%7D"
      }, {'subst' => 'true'})

  end

end