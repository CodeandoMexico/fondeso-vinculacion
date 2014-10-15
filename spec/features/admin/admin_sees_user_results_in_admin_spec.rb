require 'spec_helper'

feature 'When the admin enters the system' do
  attr_reader :fund, :user_with_submitted_questionary, :admin

  before do
    @fund = FactoryGirl.create :fund
    @user_with_submitted_questionary = FactoryGirl.create :user_with_submitted_questionary
    @admin = FactoryGirl.create :admin
    sign_in admin
  end

  it 'he should see be able to see all the funds' do
    click_link 'Programas'
    expect(current_path).to eq funds_path
    expect(page).to have_content fund.name
  end

  it 'he should see be able to see the users results' do
    click_link 'Usuarios'
    expect(page).to have_content user_with_submitted_questionary.email
    expect(page).to have_content user_with_submitted_questionary.delegations[:home]
    expect(page).to have_content user_with_submitted_questionary.delegations[:business]
  end

  def sign_in(user)
    visit new_admin_session_path
    fill_in "admin_email", with: user.email
    fill_in "admin_password", with: user.password
    click_button "Entrar"
  end
end
