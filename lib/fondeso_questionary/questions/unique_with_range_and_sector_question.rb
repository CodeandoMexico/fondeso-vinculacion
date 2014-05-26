class FondesoQuestionary
  class UniqueWithRangeAndSectorQuestion < Question
    def add_points_for_answer(selected_option, business)
      negative_associations_for_option_and_business(selected_option, business).each do |profile_id|
        business.add_to_profile_score(profile_id, -1)
      end

      positive_associations_for_option_and_business(selected_option, business).each do |profile_id|
        business.add_to_profile_score(profile_id, 1)
      end
    end

    private

    def positive_associations_for_option_and_business(selected_option, business)
      associations.fetch('positive').select do |key_with_range_and_sector|
        match_associations_key(key_with_range_and_sector, selected_option, business)
      end.values.first || :not_matched_key
    end

    def negative_associations_for_option_and_business(selected_option, business)
      associations.fetch('negative').select do |key_with_range_and_sector|
        match_associations_key(key_with_range_and_sector, selected_option, business)
      end.values.first || :not_matched_key
    end

    def match_associations_key(key, selected_option, business)
      range, sector, except_sector = key.values_at('range', 'sector', 'except_sector')

      range === selected_option.to_i &&
        (sector.nil? && except_sector.nil? ||
         sector.present? && except_sector.nil? && business.sector == Sector.new(sector) ||
         sector.nil? && except_sector.present? && business.sector != Sector.new(except_sector))
    end
  end
end
