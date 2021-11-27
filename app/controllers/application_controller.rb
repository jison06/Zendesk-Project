# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def zendesk
    @zendesk ||= Apis::Zendesk.new
  end
end
