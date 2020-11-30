class HomeController < ApplicationController

  before_action :forbid_login_user,{only:[:top]}

  def top
  end

  def about

  end

  def trial # anyways it won't work since it needs to route in unique server for 2 operations..
    url = "http://localhost:3000/login"

    get_response = HTTParty.get(url)
    noko_doc = Nokogiri::HTML(get_response)
    auth_token = noko_doc.css('form').css('input[name="authenticity_token"]').first.values[2]
    cookie_hash = HTTParty::CookieHash.new
    get_response.get_fields('Set-Cookie').each { |c| cookie_hash.add_cookies(c) }

    params = {"utf8" => "✓", "authenticity_token" => auth_token, "email"=>ENV["TRY"],
              "password"=>1111}

    params["commit"] = "Login"

    response = HTTParty.post("http://localhost:3000/login", {:body=>params, headers: {'Cookie' => cookie_hash.to_cookie_string }} )
    pp response.body
  end

  def trial2
    @stack_exchange = StackExchange.new("stackoverflow", 2)
  end

  def trial3 # anyways it won't work since it needs to route in unique server for 2 operations..
    url = "http://localhost:3000/users"

    get_response = HTTParty.get(url)
    noko_doc = Nokogiri::HTML(get_response)
    auth_token = noko_doc.css('form').css('input[name="authenticity_token"]').first.values[2]
    cookie_hash = HTTParty::CookieHash.new
    get_response.get_fields('Set-Cookie').each { |c| cookie_hash.add_cookies(c) }

    #params = {"utf8" => "✓", "authenticity_token" => auth_token,"name"=> "HTTP yui",
    #"email"=>"", "user_password"=>1111, "created_at" => Time.new.to_s[0...-6],
    #"updated_at" => Time.new.to_s[0...-6]}
    # CHECK CAREFULLY THE NAME OF PARAMS!!
    params = {"utf8" => "✓", "authenticity_token" => auth_token,"user_name"=> "HTTP yui",
    "email"=>ENV["TRY2"], "user_password"=>1111}#, "created_at" => Time.new.to_s[0...-6],
    #"updated_at" => Time.new.to_s[0...-6]}



    #params["commit"] = "create"

    #response = HTTParty.post("http://localhost:3000/users", {:basic_auth=>params, headers: {'Cookie' => cookie_hash.to_cookie_string }} )
    response = HTTParty.post("http://localhost:3000/users", {:body=>params, headers: {'Cookie' => cookie_hash.to_cookie_string }} )

    pp response.body
  end
end
