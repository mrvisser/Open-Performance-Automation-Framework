#!/usr/bin/env ruby

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"

# 
# == Synopsis
#
# Contacts class containing all operations around my messages
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Messages

  attr_accessor :session

  def initialize(session_obj)
    @session = session_obj
  end

  # Load inbox
  def my_inbox(username)
    request = SessionUtil.new(@session).create_txn_reqs('my_inbox')
    request.add('/var/message/boxcategory-all.json?box=inbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=message&_charset_=utf-8&_=1342651323360')
    request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1342651323407",
          {}, { 'subst' => 'true' })
  end

  # Load my invitations
  def my_invitations(username)
    request = SessionUtil.new(@session).create_txn_reqs('my_invitations')
    request.add('/var/message/boxcategory-all.json?box=inbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=invitation&_charset_=utf-8&_=1342651660506')
    request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1342651660558",
          {}, { 'subst' => 'true' })
  end

  # Load my sent items
  def my_sent(username)
    request = SessionUtil.new(@session).create_txn_reqs('my_sent_messages')
    request.add('/var/message/boxcategory-all.json?box=outbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=*&_charset_=utf-8&_=1342651891757')
  end

  # Load trash
  def my_trash(username)
    request = SessionUtil.new(@session).create_txn_reqs('my_trash')
    request.add('/var/message/boxcategory-all.json?box=trash&items=18&page=0&sortOn=_created&sortOrder=desc&category=*&_charset_=utf-8&_=1342652016515')
  end

end
