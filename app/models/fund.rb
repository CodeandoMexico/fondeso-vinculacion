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

  private

  def self.array_field_is_empty(value)
    value.length <= 1
  end

  def self.search_fund(category_name)
    # this can and should be optimized, it's because we're using serialize on the classification
    all.select { |fund| fund_has_category_name(fund, category_name) }
  end

  private

  def self.fund_has_category_name(fund, category_name)
    categories = fund.clasification.map { |c| c.gsub(/\s+/, "").downcase.parameterize.to_s } # convert as uri
    categories.include? category_name
  end
end
