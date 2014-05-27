module Fondeso
  module Questions
    class UniqueWithRangeAndSectorQuestion < Question
      def add_points_for_answer(selected_option, business)
        negative_associations_for_option(selected_option, business).each do |profile_id|
          business.add_to_profile_score(profile_id, -1)
        end

        positive_associations_for_option(selected_option, business).each do |profile_id|
          business.add_to_profile_score(profile_id, 1)
        end
      end

      private

      def match_associations_key?(key, selected_option, business)
        range, sector, except_sector = key.values_at('range', 'sector', 'except_sector')

        range === selected_option.to_i &&
          (sector.nil? && except_sector.nil? ||
           sector.present? && except_sector.nil? && business.sector == Sector.new(sector) ||
           sector.nil? && except_sector.present? && business.sector != Sector.new(except_sector))
      end
    end
  end
end
