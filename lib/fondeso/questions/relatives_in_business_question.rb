module Fondeso
  module Questions
    class RelativesInBusinessQuestion < Question
      def add_points_for_answer(answer, business)
        average = answer.to_f / business.answer_to_question('2.A.4').to_f

        negative_associations_for_option(average).each do |profile_id|
          business.add_to_profile_score(profile_id, -1)
        end

        positive_associations_for_option(average).each do |profile_id|
          business.add_to_profile_score(profile_id, 1)
        end
      end
    end
  end
end
