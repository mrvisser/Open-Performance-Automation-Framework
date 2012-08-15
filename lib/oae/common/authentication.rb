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

class Authentication
  
  attr_accessor :session
  
  def initialize(session_obj)
    @session = session_obj
  end
  
  # Register a new user
  def register(username, opts={})
    
    self.login(username, opts[:password], {:load_homepage => false, :thinktime => false})
    
  end
  
  # Login to OAE
  def login(username='admin', password='admin', opts ={})
    
    defaults = {
      :accept_terms => false,
      :uid_var_name => 'auth_login_uid',
      :uid_var_regex => '\"uid\":\"\([^\"]+\)',
      :dashboard_id_var_name => 'dashboard_id',
      :dashboard_id_var_regex => '<div id=\'widget_dashboard_\([^\']+\)',
      # Separating email into local and domain for URL escaping purposes
      # Can't escapse dynamic variable values and need to escape the @
      :email_local_var_name => 'auth_login_email_local',
      :email_local_var_regex => '\"email\":\"\([^\@]+\)',
      :email_domain_var_name => 'auth_login_email_domain',
      :email_domain_var_regex => '\"email\":\"[^\@]+\@\([^\"]+\)',
      :first_name_var_name => 'auth_login_first_name',
      :first_name_var_regex => '\"firstName\":\"\([^\"]+\)',
      :last_name_var_name => 'auth_login_last_name',
      :last_name_var_regex => '\"lastName\":\"\([^\"]+\)'  
    }
    
    opts = defaults.merge(opts)
    
    request = SessionUtil.new(@session).create_txn_reqs('login')
    
    request.add('/system/sling/formlogin',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakaiauth%3Alogin=1&sakaiauth%3Aun=#{username}&sakaiauth%3Apw=#{password}&_charset_=utf-8"
      }, {'subst' => 'true'}
    )

    request.add('/system/me?_charset_=utf-8&_=1323968258852', {},
      {
        :dyn_variables => [
          {"name" => opts[:email_local_var_name], "re" => opts[:email_local_var_regex]},
          {"name" => opts[:email_domain_var_name], "re" => opts[:email_domain_var_regex]},
          {"name" => opts[:first_name_var_name], "re" => opts[:first_name_var_regex]},
          {"name" => opts[:last_name_var_name], "re" => opts[:last_name_var_regex]}
        ]
      })
    
    request.add('/var/widgets.json?callback=define')
    
    # Accept terms
    if(opts[:accept_terms])
      request.add('/system/ucam/acceptterms?unchanged&_charset_=utf-8',
        {
          'method' => 'POST',
          'content_type' => '',
          'contents' => ""
        }
      )
    end
    
    # Return dynamic content that other methods in test may need
    return {
      :uid => "%%_#{opts[:uid_var_name]}%%",
      :dashboard_id => "%%_#{opts[:dashboard_id_var_name]}%%",
      :email => "%%_#{opts[:email_local_var_name]}%%@%%_#{opts[:email_domain_var_name]}%%",
      :first_name => "%%_#{opts[:first_name_var_name]}%%",
      :last_name => "%%_#{opts[:last_name_var_name]}%%"
    }
    
  end
  
  # Logout
  def logout
    request = SessionUtil.new(@session).create_txn_reqs('logout')
    
    request.add('/logout')
    request.add('/var/templates/worlds.2.json?_charset_=utf-8')
    request.add('/var/presence.json',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakai%3Astatus=offline&_charset_=utf-8"
      }
    )
    
    request.add('/system/me?_charset_=utf-8&_=1323971191834')
    request.add('/system/sling/logout?resource=/dev/index.html&_charset_=utf-8')
  end
  
  
end
