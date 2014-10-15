task add_default_geographic_operator_to_funds: :environment do
  Fund.all.each do |f|
    f.geographic_operator = DELEGATION_OR_SELECTOR
    f.save
  end
end
