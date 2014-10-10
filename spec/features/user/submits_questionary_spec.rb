require 'spec_helper'

feature 'When a user submits an answered questionary' do
  attr_reader :user_with_submitted_questionary

  before do
    @user_with_submitted_questionary = FactoryGirl.create :user_with_submitted_questionary
  end

  scenario 'should see a list of funds' do
    sign_in user_with_submitted_questionary
    expect(page).to have_content 'Programas Recomendados'
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in "user_email",    with: user.email
    fill_in "user_password", with: user.password
    click_button "ENTRAR"
  end
end
