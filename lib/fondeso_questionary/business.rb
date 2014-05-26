class FondesoQuestionary
  class Business
    attr_accessor :sector

    def find_profile(name_or_profile_id)
      profiles.select { |profile| profile.identifiable_by?(name_or_profile_id) }.first
    end

    def current_profile_score(profile_id)
      find_profile(profile_id).score
    end

    def add_to_profile_score(profile_id, points)
      find_profile(profile_id).add_to_score(points)
    end

    private

    def profiles
      @profiles ||= FONDESO_PROFILES.map { |profile| Profile.new(profile) }
    end
  end
end
