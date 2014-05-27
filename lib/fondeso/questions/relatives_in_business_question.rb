module Fondeso
  module Questions
    class RelativesInBusinessQuestion < Question
      def add_points_for_answer(answer, business)
        average = average_of_relatives(answer, business)

        negative_associations_for_option(average).each do |profile_id|
          business.add_to_profile_score(profile_id, -1)
        end

        positive_associations_for_option(average).each do |profile_id|
          business.add_to_profile_score(profile_id, 1)
        end
      end

      private

      def average_of_relatives(answer, business)
        answer_to = ->(question_id) { business.answer_to_question(question_id) }

        (answer.to_f + answer_to.('2.A.5').to_f) / answer_to.('2.A.4').to_f
      end
    end
  end
end
