require 'spec_helper'
require_relative 'helpers/session'

feature 'User browses the list of links' do
  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end
  scenario 'when opening the home page' do
    user = User.first
    Peep.create(content: "I'm happy",
                user: user,
                created_at: Time.now)
    Peep.create(content: "I'm washing the dishes",
                user: user,
                created_at: Time.now)
    Peep.create(content: "I'm cooking dinner",
                user: user,
                created_at: Time.now)
    Peep.create(content: "I'm watching football",
                user: user,
                created_at: Time.now)
    expect(Peep.count).to eq(4)
    visit '/'
    expect(page).to have_content("I'm happy")
  end
end
