FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "name#{n}" }
    sequence(:email) {|n| "correo#{n}@codeandomexico.org" }
    password "password"
    password_confirmation "password"
    number_of_recommended_funds 0
    profile_created_at Date.today
    profile_updated_at Date.today


    factory :user_with_submitted_questionary do
      # answers answer_params
      category { { "uri" => 'necesidad-startup' } }
      filters { {
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
      } }
      priorities { [
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
      ] }
      delegations { {
         "home"=>"Azcapotzalco",
         "business"=>"Azcapotzalco"
      } }
    end
  end
end
