require 'spec_helper'

feature 'When a user submits an answered questionary' do
  attr_reader :category
  before :each do
    # user = FactoryGirl.create :user
    @category = 'necesidad-startup'
    # dummy funds that doesn't have custom filters, geographic or similar
    FactoryGirl.create :fund
    FactoryGirl.create :fund
    FactoryGirl.create :fund
    FactoryGirl.create :fund
    FactoryGirl.create :fund
    # special geographic funds
    FactoryGirl.create :home_only_cuajimalpa_fund
    FactoryGirl.create :business_only_cuajimalpa_fund
    FactoryGirl.create :home_AND_business_cuajimalpa_fund
    FactoryGirl.create :home_OR_business_cuajimalpa_fund
    FactoryGirl.create :multiple_home_and_business_delegations_fund
  end

  it 'and the user does not live in DF' do
    expect(fetch_funds_with(user_does_not_live_in_DF).length).to eq 5
  end

  it 'and the user lives in cuajimalpa' do
    expect(fetch_funds_with(user_lives_in_cuajimalpa).length).to eq 8
  end

  it 'and the user business is in cuajimalpa' do
    expect(fetch_funds_with(user_business_is_in_cuajimalpa).length).to eq 7
  end

  it 'and the user lives AND his business is in cuajimalpa' do
    expect(fetch_funds_with(user_lives_and_business_is_in_cuajimalpa).length).to eq 10
  end

  it 'and the user lives in álvaro obregón' do
    expect(fetch_funds_with(user_lives_in_alvaro).length).to eq 6
  end

  it 'and the business is in Benito Juarez' do
    expect(fetch_funds_with(user_business_is_in_benito_juarez).length).to eq 6
  end

  it 'and the business is in coayacán' do
    expect(fetch_funds_with(user_business_is_in_coayacan).length).to eq 6
  end

  it 'and the business is in Tláhuac' do
    expect(fetch_funds_with(user_business_is_in_tlahuac).length).to eq 5
  end

  def fetch_funds_with(delegations)
    Fund.search_with_profile_and_filters(category, filters_not_activated, priority_params, delegations)
  end

  def user_does_not_live_in_DF
    {
       "home"=>"",
       "business"=>""
    }
  end

  def user_business_is_in_cuajimalpa
    {
       "home"=>"",
       "business"=>"Cuajimalpa de Morelos"
    }
  end

  def user_business_is_in_benito_juarez
    {
       "home"=>"",
       "business"=>"Benito Juárez"
    }
  end

  def user_business_is_in_coayacan
    {
       "home"=>"",
       "business"=>"Coyoacán"
    }
  end

  def user_business_is_in_tlahuac
    {
       "home"=>"",
       "business"=>"Tláhuac"
    }
  end

  def user_lives_in_cuajimalpa
    {
       "home"=>"Cuajimalpa de Morelos",
       "business"=>""
    }
  end

  def user_lives_in_alvaro
    {
       "home"=>"Álvaro Obregón",
       "business"=>""
    }
  end

  def user_lives_and_business_is_in_cuajimalpa
    {
       "home"=>"Cuajimalpa de Morelos",
       "business"=>"Cuajimalpa de Morelos"
    }
  end

  def priority_params
    [
       {
          "priority"=>3,
          "value"=>"a",
          "label"=>"Conseguir financiamiento / Acceder a instrumentos financieros."
       },
       {
          "priority"=>2,
          "value"=>"b",
          "label"=>"Diseñar o mejorar mi plan de negocios."
       },
       {
          "priority"=>1,
          "value"=>"c",
          "label"=>"Incrementar la productividad / Mejorar procesos."
       }
    ]
  end

  def filters_not_activated
    {
       "MUJ"=>false,
       "RUR"=>false,
       "JOV"=>false,
       "TER"=>false,
       "ART"=>false,
       "TAB"=>false,
       "BAC"=>false,
       "EXP"=>false,
       "MAN"=>false,
       "PIN"=>false,
       "CON"=>false,
       "TUR"=>false,
       "ATI"=>false,
       "IND"=>false,
       "TIC"=>false
    }
  end

  def filters_activated
    {
       "MUJ"=>true,
       "RUR"=>true,
       "JOV"=>true,
       "TER"=>true,
       "ART"=>true,
       "TAB"=>true,
       "BAC"=>true,
       "EXP"=>true,
       "MAN"=>true,
       "PIN"=>true,
       "CON"=>true,
       "TUR"=>true,
       "ATI"=>true,
       "IND"=>true,
       "TIC"=>true
    }
  end
end
