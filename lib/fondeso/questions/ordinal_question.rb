module Fondeso
  module Questions
    class OrdinalQuestion < Question
      def add_points_for_answer(answer, user)
        answer.each do |option, value|
          positive_associations_for_option(option).each do |profile_id|
            if (1..3).include? value.to_i
              add_points_to_profile(user, profile_id, 1.0 / value.to_i)
            else
              add_points_to_profile(user, profile_id, -1)
            end
          end
        end
      end
    end
  end
end
