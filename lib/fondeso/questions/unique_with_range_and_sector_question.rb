module Fondeso
  module Questions
    class UniqueWithRangeAndSectorQuestion < Question
      def add_points_for_answer(selected_option, user)
        negative_associations_for_option(selected_option, user).each do |profile_id|
          add_points_to_profile(user, profile_id, -1)
        end

        positive_associations_for_option(selected_option, user).each do |profile_id|
          add_points_to_profile(user, profile_id, 1)
        end
      end

      private

      def match_associations_key?(key, selected_option, user)
        range, sector, except_sector = key.values_at('range', 'sector', 'except_sector')

        range === selected_option.to_i &&
          (sector.nil? && except_sector.nil? ||
           sector.present? && except_sector.nil? && user.business_sector == Sector.new(sector) ||
           sector.nil? && except_sector.present? && user.business_sector != Sector.new(except_sector))
      end
    end
  end
end
