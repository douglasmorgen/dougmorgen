require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  subject(:inquiry) do
    described_class.new(
      name: 'Doug',
      email: 'doug@example.com',
      message: 'Need help automating operations.',
      honeypot: ''
    )
  end

  it 'is valid with required attributes' do
    expect(inquiry).to be_valid
  end

  it 'requires a name' do
    inquiry.name = nil
    expect(inquiry).not_to be_valid
    expect(inquiry.errors[:name]).to include("can't be blank")
  end

  it 'requires an email' do
    inquiry.email = nil
    expect(inquiry).not_to be_valid
    expect(inquiry.errors[:email]).to include("can't be blank")
  end

  it 'requires a valid email format' do
    inquiry.email = 'not-an-email'
    expect(inquiry).not_to be_valid
    expect(inquiry.errors[:email]).to include('is invalid')
  end

  it 'requires a message' do
    inquiry.message = nil
    expect(inquiry).not_to be_valid
    expect(inquiry.errors[:message]).to include("can't be blank")
  end

  it 'rejects a filled honeypot' do
    inquiry.honeypot = 'bot-filled'
    expect(inquiry).not_to be_valid
    expect(inquiry.errors[:honeypot]).to include('must be blank')
  end

  it 'defaults status to new' do
    inquiry.valid?
    expect(inquiry.status).to eq('new')
  end

  it 'defaults source page to start' do
    inquiry.valid?
    expect(inquiry.source_page).to eq('/start')
  end
end
