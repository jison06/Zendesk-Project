require 'rails_helper'
require 'webmock/rspec'

RSpec.describe TicketsController, type: :controller do
  let(:api_response) do
    {
      "tickets": [
        {
          "url": 'https://zcc-jison.zendesk.com/api/v2/tickets/1.json',
          "id": 1,
          "external_id": nil,
          "via": {
            "channel": 'sample_ticket',
            "source": {
              "from": {},
              "to": {},
              "rel": nil
            }
          },
          "created_at": '2021-11-19T21:37:15Z',
          "updated_at": '2021-11-19T21:37:15Z',
          "type": 'incident',
          "subject": 'Sample ticket: Meet the ticket',
          "raw_subject": 'Sample ticket: Meet the ticket',
          "description": "Hi there,\n\nI’m sending an email because I’m having a problem setting up your new product. Can you help me troubleshoot?\n\nThanks,\n The Customer\n\n",
          "priority": 'normal',
          "status": 'open',
          "recipient": nil,
          "requester_id": 1_909_814_379_185,
          "submitter_id": 1_909_814_375_645,
          "assignee_id": 1_909_814_375_645,
          "organization_id": nil,
          "group_id": 1_900_001_548_285,
          "collaborator_ids": [],
          "follower_ids": [],
          "email_cc_ids": [],
          "forum_topic_id": nil,
          "problem_id": nil,
          "has_incidents": false,
          "is_public": true,
          "due_at": nil,
          "tags": %w[
            sample
            support
            zendesk
          ],
          "custom_fields": [],
          "satisfaction_rating": nil,
          "sharing_agreement_ids": [],
          "fields": [],
          "followup_ids": [],
          "ticket_form_id": 1_900_000_970_325,
          "brand_id": 1_900_000_501_125,
          "allow_channelback": false,
          "allow_attachments": true
        },
        {
          "url": 'https://zcc-jison.zendesk.com/api/v2/tickets/2.json',
          "id": 2,
          "external_id": nil,
          "via": {
            "channel": 'api',
            "source": {
              "from": {},
              "to": {},
              "rel": nil
            }
          },
          "created_at": '2021-11-19T21:45:48Z',
          "updated_at": '2021-11-19T21:45:48Z',
          "type": nil,
          "subject": 'velit eiusmod reprehenderit officia cupidatat',
          "raw_subject": 'velit eiusmod reprehenderit officia cupidatat',
          "description": "Aute ex sunt culpa ex ea esse sint cupidatat aliqua ex consequat sit reprehenderit. Velit labore proident quis culpa ad duis adipisicing laboris voluptate velit incididunt minim consequat nila. Laboris adipisicing reprehenderit minim tempor officia ullamco occaecat ut laborum.\n\nAliquip velit adipisicing exercitation irure aliqua qui. Commodo eu laborum cillum nostrud eu. Mollit duis qui non ea deserunt est est et officia ut excepteur Lorem pariatur deserunt.",
          "priority": nil,
          "status": 'open',
          "recipient": nil,
          "requester_id": 1_909_814_375_645,
          "submitter_id": 1_909_814_375_645,
          "assignee_id": 1_909_814_375_645,
          "organization_id": 1_900_146_270_485,
          "group_id": 1_900_001_548_285,
          "collaborator_ids": [],
          "follower_ids": [],
          "email_cc_ids": [],
          "forum_topic_id": nil,
          "problem_id": nil,
          "has_incidents": false,
          "is_public": true,
          "due_at": nil,
          "tags": %w[
            est
            incididunt
            nisi
          ],
          "custom_fields": [],
          "satisfaction_rating": nil,
          "sharing_agreement_ids": [],
          "fields": [],
          "followup_ids": [],
          "ticket_form_id": 1_900_000_970_325,
          "brand_id": 1_900_000_501_125,
          "allow_channelback": false,
          "allow_attachments": true
        }
      ]
    }.to_s
  end
  before do
    stub_request(:get, 'https://zcc-jison.zendesk.com/api/v2/tickets?page=1&per_page=25')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Basic amlzb24wNzA5QGdtYWlsLmNvbTphWkI1TDAkQSQkQ1FVMiQ=',
          'User-Agent' => 'Faraday v1.8.0'
        }
      )
      .to_return(status: 200, body: api_response, headers: {})
  end

  describe 'GET /index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    describe 'responds_to' do
      context 'returns the right content type' do
        it 'responds to html by default' do
          get :index
          expect(response.content_type).to include 'text/html'
        end

        it 'responds to json when provided' do
          get :index, format: :json
          expect(response.content_type).to include 'application/json'
        end
      end

      context 'renders the right template' do
        subject { get :index }
        it 'renders the right html template' do
          expect(subject).to render_template(:index)
        end

        context 'when json is requested' do
          subject { get :index, format: :json }
          it 'renders the right jbuilder' do
            expect(subject).to render_template('tickets/_tickets.json')
          end
        end
      end

      describe 'when there is an error' do
        let(:error_response) do
          {
            error: true,
            errorMessage: 'Failed to retrieve tickets at this time. Please try again later.'
          }
        end

        before do
          stub_request(:get, 'https://zcc-jison.zendesk.com/api/v2/tickets?page=1&per_page=25')
            .with(
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Basic amlzb24wNzA5QGdtYWlsLmNvbTphWkI1TDAkQSQkQ1FVMiQ=',
                'User-Agent' => 'Faraday v1.8.0'
              }
            )
            .to_return(status: 500, body: '', headers: {})
        end

        it 'responds with an error message' do
          get :index, format: :json, params: { page: 1 }
          expect(response.code).to eq('500')
          expect(response.body).to eq(error_response.to_json)
        end
      end
    end
  end
end
