FactoryGirl.define do
  factory :fund do
    sequence(:friendly_id) {|n| "friendlyid#{n}" }
    sequence(:name) {|n| "name#{n}" }
    sequence(:description) {|n| "description#{n}" }
    sequence(:institution) {|n| "institution#{n}" }
    clasification { ["", "Necesidad - Startup", "Tradicional - Startup", "Tradicional - Crecimiento"] }
    characteristics { ["", "Activo fijo"] }
    deliver_method { ["", "Bolsa de trabajo/Empleabilidad"] }
  end
end
