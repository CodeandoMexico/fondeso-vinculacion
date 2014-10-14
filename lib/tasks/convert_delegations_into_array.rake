IGNORE_LIST = [ "", nil, "No hay restricción por delegación" ]

task verify_convert_delegations_into_array: :environment do
  Fund.all.each do |f|
    new_home_delegation = new_delegation_format( f, f.home_delegation ) unless f.home_delegation.is_a?(Array)
    new_business_delegation = new_delegation_format( f, f.business_delegation ) unless f.business_delegation.is_a?(Array)
  end
end

task convert_delegations_into_array: :environment do
  Fund.all.each do |f|
    new_home_delegation = new_delegation_format( f, f.home_delegation ) unless f.home_delegation.is_a?(Array)
    new_business_delegation = new_delegation_format( f, f.business_delegation ) unless f.business_delegation.is_a?(Array)

    f.update_attributes(home_delegation: new_home_delegation, business_delegation: new_business_delegation)
  end
end

def new_delegation_format( fund, previous_delegation )
    new_array = [ "" ]
    new_array.push(previous_delegation) unless IGNORE_LIST.include? previous_delegation
    print "#{previous_delegation} #{new_array.inspect}\n"
    new_array
end
