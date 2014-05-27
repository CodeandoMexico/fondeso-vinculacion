module Fondeso
  module Questions
    class RelativesInBusinessQuestion < Question
      def add_points_for_answer(answer, business)
        average = average_of_relatives(answer, business)
        puts average

        negative_associations_for_average(average).each do |profile_id|
          business.add_to_profile_score(profile_id, -1)
        end

        positive_associations_for_average(average).each do |profile_id|
          business.add_to_profile_score(profile_id, 1)
        end
      end

      private

      def average_of_relatives(answer, business)
        answer_to = ->(question_id) { business.answer_to_question(question_id) }

        (answer.to_f + answer_to.('2.A.5').to_f) / answer_to.('2.A.4').to_f
      end

      def positive_associations_for_average(average)
        associations.fetch('positive').select { |range| range === average }.values.first ||
          :not_matched_key
      end

      def negative_associations_for_average(average)
        associations.fetch('negative').select { |range| range === average }.values.first ||
          :not_matched_key
      end
    end
  end
end
