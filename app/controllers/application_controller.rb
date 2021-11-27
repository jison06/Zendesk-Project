class ApplicationController < ActionController::Base
  require 'faraday'

  private

  def zendesk_client
    username = 'jison0709@gmail.com'
    password = 'aZB5L0$A$$CQU2$'
    url = 'https://zcc-jison.zendesk.com'
    @zendesk_client ||= Faraday.new(url: url) do |conn|
      conn.adapter Faraday.default_adapter
      conn.basic_auth(username, password)
    end
  end

  def headers
    { 'Content-Type': 'application/json' }
  end
end
