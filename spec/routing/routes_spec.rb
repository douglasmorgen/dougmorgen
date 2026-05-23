require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  it 'routes home to high voltage' do
    expect(get: '/').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'home')
  end

  it 'routes services to high voltage page' do
    expect(get: '/services').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'services')
  end

  it 'routes work to high voltage page' do
    expect(get: '/work').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'work')
  end

  it 'routes about to high voltage page' do
    expect(get: '/about').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'about')
  end

  it 'routes blog to high voltage page' do
    expect(get: '/blog').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'blog')
  end

  it 'routes faq to high voltage page' do
    expect(get: '/faq').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'faq')
  end

  it 'routes resume to high voltage page' do
    expect(get: '/resume').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'resume')
  end

  it 'routes contact to high voltage page' do
    expect(get: '/contact').to route_to(controller: 'high_voltage/pages', action: 'show', id: 'contact')
  end

  it 'routes start to inquiries new' do
    expect(get: '/start').to route_to('inquiries#new')
  end

  it 'routes inquiries create' do
    expect(post: '/inquiries').to route_to('inquiries#create')
  end

  it 'routes inquiry thank-you' do
    expect(get: '/start/thanks').to route_to('inquiries#thank_you')
  end

  it 'routes admin inquiries index' do
    expect(get: '/admin/inquiries').to route_to('admin/inquiries#index')
  end
end
