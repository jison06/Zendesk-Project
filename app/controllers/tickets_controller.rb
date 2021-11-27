# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    fetch_tickets(params)
    respond_to do |format|
      format.html
      format.json { render('tickets/_tickets.json', locals: {tickets: @tickets, count: @count})}
    end
  end

  private

  def fetch_tickets(params)
    return unless params['page']

    tickets = zendesk_client.get('/api/v2/tickets', { per_page: 25, page: params['page'] })
    if tickets.status == 200
      @tickets = JSON.parse(tickets.body)['tickets'] || []
      @count = JSON.parse(tickets.body)['count'] || 0
    end
  end
end
