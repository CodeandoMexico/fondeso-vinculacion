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

    def profile_score_for_question(question, profile_id)
      find_profile(profile_id).score_for_question(question)
    end

    def add_to_profile_score(profile_id, question, points)
      find_profile(profile_id).add_to_score(question, points)
    end

    def answer_question(question, answer)
      add_answer(question, answer)
      initialize_profile_scores_for_question(question)
      question.add_points_for_answer(answer, self)
    end

    def answer_to_question(question_id)
      answers.fetch(question_id)
    end

    private

    def initialize_profile_scores_for_question(question)
      profiles.each do |profile|
        profile.initialize_score_for_question(question)
      end
    end

    def add_answer(question, answer)
      answers[question.question_id] = answer
    end

    def answers
      @answers ||= {}
    end

    def profiles
      @profiles ||= FONDESO_PROFILES.map { |profile| Profile.new(profile) }
    end
  end
end
