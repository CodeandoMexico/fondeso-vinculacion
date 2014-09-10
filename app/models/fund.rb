class Fund < ActiveRecord::Base
  serialize :characteristics, Array
  serialize :deliver_method, Array
  serialize :clasification, Array
  serialize :special_filters, Array
  serialize :custom_delegation, Array

  store :contact_details, accessors: [ :contact, :address, :phone, :other_phone, :email ], coder: JSON

  validates :friendly_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :institution, presence: true
  validates_each :characteristics, :deliver_method, :clasification, on: :update do |record, attr, value|
    record.errors.add(attr, :blank) if array_field_is_empty value
  end

  def self.search(value)
      where('name ILIKE ? OR institution ILIKE ?', "%#{value}%", "%#{value}%")
  end

  def has_complete_information?
    characteristics.length > 1 && deliver_method.length > 1 && clasification.length > 1
  end

  def has_incomplete_information?
    characteristics.length <= 1 && deliver_method.length <= 1 && clasification.length <= 1
  end

  def has_incomplete_contact_information?
    contact_details[:contact].blank? && contact_details[:address].blank? && contact_details[:phone].blank?
  end

  def has_classification?(classification_name)
    clasification.each do |c|
      return true if c == classification_name
    end
    false
  end

  def is_it_from_fondeso?
    priority == "Fondeso"
  end


  def self.search_with_category_and_filters(user_profile_name, questionary_activated_filters, priorities)
    # this can and should be optimized, it's because we're using serialize on the classification
    funds = all.select do |fund|
      fund_has_user_profile(fund, user_profile_name) &&
      fund_responds_to_filters(fund, questionary_activated_filters)
    end

    order_by_priority funds, user_profile_name, priorities
  end

  private

  def self.order_by_priority(funds, user_profile_name, priorities)
    order = {
      "0" => [],
      "1" => [],
      "2" => [],
      "3" => [],
      "4" => [],
      "5" => [],
      "6" => [],
      "20" => [],
    }
    funds.each do |f|
      if f.is_it_from_fondeso?
        order["0"] << f
      elsif f.has_classification?("Necesidad - Aún no existe")
        order["1"] << f
      elsif fund_is_social_and_current_profile_is_social? f, user_profile_name
        order["2"] << f
      elsif fund_is_cultural_and_current_profile_is_cultural? f, user_profile_name
        order["3"] << f
      elsif priorities.present? && fund_priority_is_the_same_as_questionary_results_first_priority?(f, priorities)
        order["4"] << f
      elsif priorities.present? && fund_priority_is_the_same_as_questionary_results_second_priority?(f, priorities)
        order["5"] << f
      elsif priorities.present? && fund_priority_is_the_same_as_questionary_results_third_priority?(f, priorities)
        order["6"] << f
      else
        order["20"] << f
      end
    end

    puts "(0)------------------------------"
    puts order["0"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(1)------------------------------"
    puts order["1"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(2)------------------------------"
    puts order["2"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(3)------------------------------"
    puts order["3"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(4)------------------------------"
    puts order["4"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(5)------------------------------"
    puts order["5"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(6)------------------------------"
    puts order["6"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }
    puts "(20)------------------------------"
    puts order["20"].each {|f| puts "#{f.name} #{f.clasification} #{f.priority}" }

    order["0"] + order["1"] + order["2"] + order["3"] + order["4"] + order["5"] + order["6"] + order["20"]
  end

  def self.fund_priority_is_the_same_as_questionary_results_first_priority?(fund, priorities)
      puts fund.priority
      puts priorities
      puts priorities.include?(fund.priority)
      priorities_match_fund(fund, priorities, 1)
  end

  def self.fund_priority_is_the_same_as_questionary_results_second_priority?(fund, priorities)
      priorities_match_fund(fund, priorities, 2)
  end

  def self.fund_priority_is_the_same_as_questionary_results_third_priority?(fund, priorities)
      priorities_match_fund(fund, priorities, 3)
  end

  def self.priorities_match_fund(fund, priorities, priority_number)
    match = priorities.select { |p| p[:label] == fund.priority }
    return false unless match.present?

    match.first[:priority] == priority_number
  end

  def self.fund_is_social_and_current_profile_is_social?(fund, user_profile_name)
    user_and_fund_category_are_a_match(fund, user_profile_name, ["Social - Startup", "Social - Crecimiento", "Social - Consolidacion"])
  end

  def self.fund_is_cultural_and_current_profile_is_cultural?(fund, user_profile_name)
      user_and_fund_category_are_a_match(fund, user_profile_name, ["Cultural - Startup", "Cultural - Crecimiento", "Cultural - Consolidacion"])
  end

  def self.user_and_fund_category_are_a_match(fund, user_profile_name, classification_and_stage)
    puts "#{fund.clasification} #{classification_and_stage[0]} #{user_profile_name}" if fund.name == "Registro electrónico de código de barras"
    (
      fund.has_classification?(classification_and_stage[0]) ||
      fund.has_classification?(classification_and_stage[1]) ||
      fund.has_classification?(classification_and_stage[2])
    ) &&
    (
      user_profile_name == (classification_and_stage[0].gsub(/\s+/, "").downcase.parameterize.to_s) ||
      user_profile_name == (classification_and_stage[1].gsub(/\s+/, "").downcase.parameterize.to_s) ||
      user_profile_name == (classification_and_stage[2].gsub(/\s+/, "").downcase.parameterize.to_s)
    )
  end

  def self.array_field_is_empty(value)
    value.length <= 1
  end


  def self.fund_has_user_profile(fund, user_profile_name)
    categories = fund.clasification.map { |c| c.gsub(/\s+/, "").downcase.parameterize.to_s } # convert as uri
    categories.include? user_profile_name
  end

  def self.fund_responds_to_filters(fund, questionary_activated_filters)
    fund.special_filters.each do |filter_full_name|
      filter_short_name = LOOK_FOR_SHORT_NAME_OF_FILTER[filter_full_name]
      next if filter_short_name.blank?

      return false if questionary_activated_filters[filter_short_name] == false
    end
    true
  end
end
