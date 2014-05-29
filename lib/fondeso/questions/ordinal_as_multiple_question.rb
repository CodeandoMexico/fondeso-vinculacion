module Fondeso
  module Questions
    class OrdinalAsMultipleQuestion < MultipleQuestion
      def match_associations_key?(associations_key, answer)
        associations_key.all? do |option_key, option_value|
          option_value == answer.fetch(option_key).present?
        end
      end
    end
  end
end
