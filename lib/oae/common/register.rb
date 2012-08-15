#!/usr/bin/env ruby

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Registration
  
  attr_accessor :session
  
  def initialize(session_obj)
    @session = session_obj
  end
  
  def load
    request = SessionUtil.new(@session).create_txn_reqs('register_load')
    
    request.add('/register')
    request.add("http://rsmart.app11.hubspot.com/salog.js.aspx",
      {}, {:external => true})
    request.add("http://rsmart.app11.hubspot.com/salog20.js?v=2.15",
      {}, {:external => true})
    request.add("http://www.google.com/recaptcha/api/js/recaptcha_ajax.js", #304
      {}, {:external => true})
    request.add('/system/me?_charset_=utf-8&_=1317932031489')
    request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fcaptcha%2Fcaptcha.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcaptcha%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324512280255')
    request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Ffooter.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324512280290')
    request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Facceptterms.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Ffileupload.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fnewaddcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fsendmessage.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Faddtocontacts.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fjoingroup.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fjoinrequestbuttons.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Ftooltip.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Faccountpreferences.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fchangepic.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fsavecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fnewsharecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fpersoninfo.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )    
    request.add('/system/captcha?_charset_=utf-8')
  end
  
  def type_username(username)
    request = SessionUtil.new(@session).create_txn_reqs('register_type_username')
    
    # Filling out - forward lookup
    #giving 404 - if using dyn variable substitution we have to parse out the part of user ID that's not dynamic
    lookup = username.match('^([^%%]+)').to_s
    for i in 1..lookup.length
      itr = i-1
      request.add("/system/userManager/user.exists.html?userid=#{lookup[0..itr]}&_charset_=utf-8&_=1317945057343", 
        {}, { 'subst' => 'true' })    
    end
  end
  
  def register(username, opts={})
    defaults = {
      :password => "password",
      :password_confirm => "password",
      :first_name => "Test",
      :last_name => "User",
      :email => "#{username}%40test.com",
      :title => "Mr.",
      :institution => "rSmart",
      :role => "Administrator",
      :phone => "555-555-5555",
      :lms => "Blackboard"
    }
    opts = defaults.merge(opts)

    request = SessionUtil.new(@session).create_txn_reqs('register')

    # Submit form
    request.add('/system/userManager/user.create.html',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&locale=en_US&timezone=America%2FPhoenix&pwd=#{opts[:password]}&pwdConfirm=#{opts[:password_confirm]}&firstName=#{opts[:first_name]}&lastName=#{opts[:last_name]}&email=#{opts[:email]}&%3Aname=#{username}&%3Asakai%3Aprofile-import=%7B%22basic%22%3A%7B%22elements%22%3A%7B%22firstName%22%3A%7B%22value%22%3A%22#{opts[:first_name]}%22%7D%2C%22lastName%22%3A%7B%22value%22%3A%22#{opts[:last_name]}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{opts[:email]}%22%7D%7D%2C%22access%22%3A%22everybody%22%7D%2C%22email%22%3A%22#{opts[:email]}%22%7D&%3Acreate-auth=reCAPTCHA.net&%3Arecaptcha-challenge=03AHJ_Vuvbk6sMH8HixXQkpvZ39wx-6hYbl5ZHFcpkxJh3_ZRBiSYxXOQWPdLPKb9F3FSpnYfZyo4huD37kHg8z3E3IsOfjotxlOh7tv4wnlVxzOtSe-7SOiNWHRmt00t7ah01jFYNczwj98zBooVQmkLL-RNsd8Axmg&%3Arecaptcha-response=tiaprw+For&%3Aregistration=%7B%22hubspotutk%22%3A%22d2374244454e4d6f8c00c49801db7495%22%2C%22title%22%3A%22#{opts[:title]}%22%2C%22institution%22%3A%22#{opts[:institution]}%22%2C%22role%22%3A%22#{opts[:role]}%22%2C%22phone%22%3A%22#{opts[:phone]}%22%2C%22currentLms%22%3A%22#{opts[:lms]}%22%2C%22contactPreferences%22%3A%7B%7D%7D",
        :auth => {:username => 'admin', :password => 'admin'}
      }, { 'subst' => 'true' })
    
  end
end