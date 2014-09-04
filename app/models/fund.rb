class Fund < ActiveRecord::Base
  serialize :characteristics, Array
  serialize :deliver_method, Array
  serialize :clasification, Array
  serialize :special_filters, Array
  serialize :custom_delegation, Array

  store :contact_details, accessors: [ :contact, :address, :phone, :other_phone, :email ], coder: JSON

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

  private

  def self.array_field_is_empty(value)
    value.length <= 1
  end

  def self.search_with_category_and_filters(category_name, questionary_activated_filters)
    # this can and should be optimized, it's because we're using serialize on the classification
    all.select do |fund|
      fund_has_category_name(fund, category_name) &&
      fund_responds_to_filters(fund, questionary_activated_filters)
    end
  end

  def self.fund_has_category_name(fund, category_name)
    categories = fund.clasification.map { |c| c.gsub(/\s+/, "").downcase.parameterize.to_s } # convert as uri
    categories.include? category_name
  end

  def self.fund_responds_to_filters(fund, questionary_activated_filters)
    fund.special_filters.each do |filter_full_name|
      filter_short_name = LOOK_FOR_SHORT_NAME_OF_FILTER[filter_full_name]
      next if filter_short_name.blank?

      return false if questionary_activated_filters[filter_short_name] == false
    end
    puts 'Fullfills the fund'
    true
  end
end
