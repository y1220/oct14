class HomeController < ApplicationController

  before_action :forbid_login_user,{only:[:top]}

  def top
  end

  def about

  end

  def trial
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
end
