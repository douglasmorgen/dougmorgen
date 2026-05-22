require 'rails_helper'

RSpec.describe 'Inquiries', type: :request do
  describe 'POST /inquiries' do
    let(:verifier) { Rails.application.message_verifier(:inquiry_form) }
    let(:form_started_at) { 10.seconds.ago.to_i }
    let(:form_signature) { verifier.generate(form_started_at, purpose: :inquiry_form_timing) }

    let(:valid_params) do
      {
        inquiry: {
          name: 'Doug Morgen',
          email: 'doug@example.com',
          company: 'Acme Co',
          phone: '555-123-1234',
          project_type: 'Rails app',
          budget: '$5k–$15k',
          timeline: 'This month',
          message: 'Need a replacement for spreadsheet workflows.',
          source_page: '/start',
          honeypot: ''
        },
        form_started_at: form_started_at,
        form_signature: form_signature
      }
    end

    it 'creates an inquiry, sends an email, and redirects to thank-you' do
      expect do
        expect do
          post inquiries_path, params: valid_params
        end.to change(ActionMailer::Base.deliveries, :count).by(1)
      end.to change(Inquiry, :count).by(1)

      expect(response).to redirect_to(inquiry_thank_you_path)
      expect(Inquiry.last.status).to eq('new')
    end

    it 'rejects spam submissions when honeypot is filled' do
      spam_params = valid_params.deep_dup
      spam_params[:inquiry][:honeypot] = 'I am a bot'

      expect do
        post inquiries_path, params: spam_params
      end.not_to change(Inquiry, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include('Please fix the following')
    end

    it 'rejects submissions that happen too quickly' do
      fast_started_at = Time.current.to_i
      fast_signature = verifier.generate(fast_started_at, purpose: :inquiry_form_timing)

      fast_params = valid_params.deep_dup
      fast_params[:form_started_at] = fast_started_at
      fast_params[:form_signature] = fast_signature

      expect do
        post inquiries_path, params: fast_params
      end.not_to change(Inquiry, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include('Please wait a few seconds and try again.')
    end

    it 'rejects submissions with an invalid form signature' do
      invalid_signature_params = valid_params.deep_dup
      invalid_signature_params[:form_signature] = 'tampered'

      expect do
        post inquiries_path, params: invalid_signature_params
      end.not_to change(Inquiry, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include('Please wait a few seconds and try again.')
    end
  end
end
