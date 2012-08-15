#!/usr/bin/env ruby

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"

# 
# == Synopsis
#
# Search class containing all operations around search
#
# Author:: Branden Visser (mailto:mrvisser@gmail.com)
#

class Search
  
  attr_accessor :session
  
  def initialize(session_obj)
    @session = session_obj
  end
  
  def load(category='all')
    request = SessionUtil.new(@session).create_txn_reqs("search_load_page")
    request.add('/var/widgets.json?callback=define')
    request.add('/system/me?_charset_=utf-8')
    request.add('/var/templates/worlds.2.json?_charset_=utf-8')
    request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fdisplayprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870134')
    request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870481')
  end
  
  #
  # Performs a general search.
  # 
  # * query: The general search term to search on (default: *)
  # * category: the category to search
  # ** Available options: all, content, people, groups, courses, research_projects
  #
  def search(query='*', category='all')
    
    request = SessionUtil.new(@session).create_txn_reqs("search_#{category}")

    case category
    when 'all'
      request.add("/var/search/general.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558141063",
          {}, { 'subst' => 'true' })
    when 'content'
      request.add("/var/search/pool/all.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558155346",
          {}, { 'subst' => 'true' })
    when 'people'
      request.add("/var/search/users.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558158607",
          {}, { 'subst' => 'true' })
    when 'groups'
      request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=group&page=0&items=18&_charset_=utf-8&_=1342558161747",
          {}, { 'subst' => 'true' })
    when 'courses'
      request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=course&page=0&items=18&_charset_=utf-8&_=1342558164687",
          {}, { 'subst' => 'true' })
    when 'research_projects'
      request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=research&page=0&items=18&_charset_=utf-8&_=1342558167607",
          {}, { 'subst' => 'true' })
    end

  end

end