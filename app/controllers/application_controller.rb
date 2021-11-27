class ApplicationController < ActionController::Base
  require 'faraday'

  private

  def zendesk_client
    username = Rails.application.credentials.config.dig(:zendesk, :username)
    password = Rails.application.credentials.config.dig(:zendesk, :password)
    url = 'https://zcc-jison.zendesk.com'
    @zendesk_client ||= Faraday.new(url: url) do |conn|
      conn.adapter Faraday.default_adapter
      conn.request(:basic_auth, username, password)
    end
  end

  def headers
    { 'Content-Type': 'application/json' }
  end
end
