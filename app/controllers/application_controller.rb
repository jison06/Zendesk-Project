# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def zendesk
    @zendesk ||= Zendesk.new
  end
end
