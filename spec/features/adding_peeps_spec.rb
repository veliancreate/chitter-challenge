require 'spec_helper'
require_relative 'helpers/session'

feature 'User adds a new peep' do
  scenario 'when browsing the homepage' do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
    sign_in('test@test.com', 'test')
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep('Hi this is great')
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.content).to eq('Hi this is great')
  end

  def add_peep(content)
    within('#new-peep') do
      fill_in 'content', with: content
    end
    click_button 'Peep!'
  end
end
