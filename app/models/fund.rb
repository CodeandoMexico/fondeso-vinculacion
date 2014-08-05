class Fund < ActiveRecord::Base
  serialize :characteristics, Array
  serialize :deliver_method, Array
  serialize :clasification, Array
  serialize :special_filters, Array
  serialize :home_delegation, Array
  serialize :business_delegation, Array

  validates :name, presence: true
  validates :description, presence: true
  validates :institution, presence: true

  # def self.find(category, stage)
  #   if stage.nil?
  #     funds.map.select { |f| f[category] == '1'}
  #   else
  #     funds.map.select { |f| f[category] == '1' and f[stage] == '1'}
  #   end
  # end
end
