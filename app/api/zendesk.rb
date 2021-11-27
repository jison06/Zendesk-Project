# frozen_string_literal: true

module Apis
  class Zendesk
    require 'faraday'
    attr_reader :username, :password, :url

    def initialize
      @username = Rails.application.credentials.config.dig(:zendesk, :username)
      @password = Rails.application.credentials.config.dig(:zendesk, :password)
      @url = 'https://zcc-jison.zendesk.com'
    end

    def client
      @client ||= Faraday.new(url: url) do |conn|
        conn.adapter Faraday.default_adapter
        conn.request(:basic_auth, username, password)
      end
    end
  end
end
