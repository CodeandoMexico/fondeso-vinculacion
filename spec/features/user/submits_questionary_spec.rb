require 'spec_helper'

feature 'This is a feature' do
  # attr_reader :member

  before do
    user = FactoryGirl.create :user
    fund = FactoryGirl.create :fund

    raise fund.inspect
  end

  scenario 'passing test' do
    pending "test pending"
  end
end
