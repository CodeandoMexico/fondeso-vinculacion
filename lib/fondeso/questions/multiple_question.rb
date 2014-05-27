module Fondeso
  module Questions
    class MultipleQuestion < Question
      def add_points_for_answer(answer, business)
        positive_associations.each do |associations_key, associations|
          if match_associations_key?(associations_key, answer)
            associations.each do |profile_id|
              business.add_to_profile_score(profile_id, 1)
            end
          end
        end

        negative_associations.each do |associations_key, associations|
          if match_associations_key?(associations_key, answer)
            associations.each do |profile_id|
              business.add_to_profile_score(profile_id, -1)
            end
          end
        end
      end

      private

      def match_associations_key?(associations_key, answer)
        associations_key.all? do |option_key, option_value|
          option_value == answer.fetch(option_key)
        end
      end
    end
  end
end
