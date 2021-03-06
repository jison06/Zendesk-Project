# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    fetch_tickets(params)
    respond_to do |format|
      # When json header is not present, render the html layout
      format.html
      # When json header is present, either handle the error or return the results from the zendesk api call
      format.json do
        if @error
          render json: { error: true, errorMessage: 'Failed to retrieve tickets at this time. Please try again later.' }, status: 500
        else
          render('tickets/_tickets.json', locals: { tickets: @tickets, count: @count })
        end
      end
    end
  end

  private

  def fetch_tickets(params)
    return unless params['page']

    tickets = zendesk.client.get('/api/v2/tickets', { per_page: 25, page: params['page'] })
    if tickets.status == 200
      # formatting variables for jbuilder
      @tickets = JSON.parse(tickets.body)['tickets'] || []
      @count = JSON.parse(tickets.body)['count'] || 0
    else
      @error = true
    end
  end
end
