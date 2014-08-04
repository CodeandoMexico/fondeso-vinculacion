class Fund < ActiveRecord::Base
  # attr_accessor :name, :description, :institution, :characteristics, :deliver_method,
  #                 :clasification, :special_filters

  # serialize :characteristics, Array
  # serialize :deliver_method, Array
  # serialize :clasification, Array
  # serialize :special_filters, Array

  validates :name, presence: true
  # validates :description, presence: true
  # validates :institution, presence: true

  # def self.find(category, stage)
  #   if stage.nil?
  #     funds.map.select { |f| f[category] == '1'}
  #   else
  #     funds.map.select { |f| f[category] == '1' and f[stage] == '1'}
  #   end
  # end
end
