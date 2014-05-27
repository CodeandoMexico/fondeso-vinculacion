module Fondeso
  module Questions
    class UniqueQuestion < Question
      def add_points_for_answer(selected_option, business)
        negative_associations_for_option(selected_option).each do |profile_id|
          business.add_to_profile_score(profile_id, -1)
        end

        positive_associations_for_option(selected_option).each do |profile_id|
          business.add_to_profile_score(profile_id, 1)
        end
      end
    end
  end
end
