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
    factory :women_fund do
      special_filters { ["", "Sexo"] }
    end

    factory :rural_fund do
      special_filters { ["", "Rural"] }
    end

    factory :young_fund do
      special_filters { ["", "Joven"] }
    end

    factory :elderly_fund do
      special_filters { ["", "Tercera Edad"] }
    end

    factory :artisan_fund do
      special_filters { ["", "Artesanos"] }
    end

    factory :corner_store_fund do
      special_filters { ["", "Tiendas de Abarrotes"] }
    end

    factory :college_fund do
      special_filters { ["", "Bachillerato"] }
    end

    factory :export_fund do
      special_filters { ["", "Exportación"] }
    end

    factory :manufacture_fund do
      special_filters { ["", "Manufactura"] }
    end

    factory :industrial_property_fund do
      special_filters { ["", "Propiedad industrial"] }
    end

    factory :construction_fund do
      special_filters { ["", "Construcción"] }
    end

    factory :turism_fund do
      special_filters { ["", "Turismo"] }
    end

    factory :access_to_it_fund do
      special_filters { ["", "Acceso a TICs"] }
    end

    # factory :legal_fund do
    #   special_filters { ["", "Legal"] }
    # end
    #
    # factory :security_fund do
    #   special_filters { ["", "Seguridad"] }
    # end

    factory :native_fund do
      special_filters { ["", "Indígenas"] }
    end

    factory :tic_fund do
      special_filters { ["", "TIC"] }
    end

    factory :two_filter_fund do
      special_filters { ["", "Sexo", "Indígenas"] }
    end

  end
end
