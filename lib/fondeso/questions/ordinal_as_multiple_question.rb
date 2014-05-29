module Fondeso
  module Questions
    class OrdinalAsMultipleQuestion < MultipleQuestion
      def match_associations_key?(key_with_options_and_values, answer)
        key_with_options_and_values.all? do |option, value|
          value == answer.fetch(option).present?
        end
      end
    end
  end
end
