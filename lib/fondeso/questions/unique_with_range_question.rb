module Fondeso
  module Questions
    class UniqueWithRangeQuestion < UniqueQuestion
      def match_associations_key?(key, answer, *other_params)
        key === answer.to_i
      end
    end
  end
end
