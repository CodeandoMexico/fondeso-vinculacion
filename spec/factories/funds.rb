FactoryGirl.define do
  factory :fund do
    sequence(:friendly_id) {|n| "friendlyid#{n}" }
    sequence(:name) {|n| "name#{n}" }
    sequence(:description) {|n| "description#{n}" }
    sequence(:institution) {|n| "institution#{n}" }
    clasification { ["", "Necesidad - Startup", "Tradicional - Startup", "Tradicional - Crecimiento"] }
    characteristics { ["", "Activo fijo"] }
    deliver_method { ["", "Bolsa de trabajo/Empleabilidad"] }

    # Here goes a list of all the different filter, to create custom funds
    factory :native_fund do
      special_filters { ["", "Indígenas"] }
    end

    factory :elderly_fund do
      special_filters { ["", "Tercera Edad"] }
    end

    factory :women_fund do
      special_filters { ["", "Sexo"] }
    end
  end
end
