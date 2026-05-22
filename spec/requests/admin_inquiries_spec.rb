require 'rails_helper'

RSpec.describe 'Admin::Inquiries', type: :request do
  let!(:inquiry) do
    Inquiry.create!(
      name: 'Admin Test',
      email: 'admin-test@example.com',
      message: 'Review this inquiry',
      honeypot: ''
    )
  end

  around do |example|
    original_user = ENV['ADMIN_USERNAME']
    original_password = ENV['ADMIN_PASSWORD']

    ENV['ADMIN_USERNAME'] = 'admin'
    ENV['ADMIN_PASSWORD'] = 'secret'

    example.run
  ensure
    ENV['ADMIN_USERNAME'] = original_user
    ENV['ADMIN_PASSWORD'] = original_password
  end

  it 'requires basic auth for admin inquiries index' do
    get admin_inquiries_path
    expect(response).to have_http_status(:unauthorized)
  end

  it 'rejects invalid credentials' do
    auth = ActionController::HttpAuthentication::Basic.encode_credentials('wrong', 'creds')
    get admin_inquiries_path, headers: { 'HTTP_AUTHORIZATION' => auth }

    expect(response).to have_http_status(:unauthorized)
  end

  it 'allows access with valid credentials' do
    auth = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'secret')
    get admin_inquiries_path, headers: { 'HTTP_AUTHORIZATION' => auth }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Inquiries')
    expect(response.body).to include('Admin Test')
  end
end
