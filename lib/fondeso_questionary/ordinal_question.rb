class FondesoQuestionary
  class OrdinalQuestion < Question
    def add_points_for_answer(answer, business)
      answer.each do |option, value|
        positive_associations_for_option(option).each do |profile_id|
          business.add_to_profile_score(profile_id, 1.0 / value)
        end
      end
    end
  end
end
