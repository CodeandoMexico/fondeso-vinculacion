require_relative 'data'

module Fondeso
  class Business
    attr_accessor :sector

    def find_profile(name_or_profile_id)
      profiles.select { |profile| profile.identifiable_by?(name_or_profile_id) }.first
    end

    def current_score
      profiles.map &:score
    end

    def current_profile_score(profile_id)
      find_profile(profile_id).score
    end

    def add_to_profile_score(profile_id, points)
      find_profile(profile_id).add_to_score(points)
    end

    def add_answer(question_id, answer)
      answers[question_id] = answer
    end

    def answer_to_question(question_id)
      answers.fetch(question_id)
    end

    private

    def answers
      @answers ||= {}
    end

    def profiles
      @profiles ||= FONDESO_PROFILES.map { |profile| Profile.new(profile) }
    end
  end
end
