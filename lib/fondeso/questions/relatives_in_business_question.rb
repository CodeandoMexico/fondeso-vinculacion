module Fondeso
  module Questions
    class RelativesInBusinessQuestion < Question
      def add_points_for_answer(answer, user)
        average = answer.to_f / user.answer_to_question('2.A.4').to_f

        negative_associations_for_option(average).each do |profile_id|
          add_points_to_profile(user, profile_id, -1)
        end

        positive_associations_for_option(average).each do |profile_id|
          add_points_to_profile(user, profile_id, 1)
        end
      end
    end
  end
end
