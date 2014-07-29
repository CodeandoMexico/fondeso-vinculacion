class Fund < ActiveRecord::Base
  attr_accessor :name, :description, :institution, :charactistics, :deliver_method,
                  :clasification, :special_filters

  # serialize :charactistics, Array
  # serialize :deliver_method, Array
  # serialize :clasification, Array
  # serialize :special_filters, Array

  # def self.find(category, stage)
  #   if stage.nil?
  #     funds.map.select { |f| f[category] == '1'}
  #   else
  #     funds.map.select { |f| f[category] == '1' and f[stage] == '1'}
  #   end
  # end
end
