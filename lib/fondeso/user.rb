module Fondeso
  class User
    attr_accessor :business_sector

    def find_profile(name_or_profile_id)
      profiles.select { |profile| profile.identifiable_by?(name_or_profile_id) }.first
    end

    def current_score
      profiles.map &:score
    end

    def winner_profile
      max = profiles.first

      sort_by_descending_scores_in profiles
      if there_is_a_tie?(profiles)
        max_profile_score = profiles.first.score
        profiles.select do |p|
          p.score == max_profile_score
        end
      else
        profiles.first
      end
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
      initialize_profiles_scores_for_question(question)
      question.add_points_for_answer(answer, self)
    end

    def answer_to_question(question_id)
      answers.fetch(question_id)
    end

    private

    def sort_by_descending_scores_in(profiles)
      profiles.sort! { |x,y| y.score <=> x.score }
    end

    def there_is_a_tie?(profiles, minimum_tie_probability=0.20)
      # Ties according the business requirements are as follows:
      #
      # If difference between first and second max profiles is less
      # than 20% AND at least one of the following criteria is met:
      #
      # 1. Profiles are from different categories (necessity, traditional).
      # 2. Profile category stages are opposing (necessity-startup, necessity-consolidation)
      #
      first_profile = profiles[0]
      second_profile = profiles[1]

      tie_detected?(first_profile, second_profile, minimum_tie_probability) &&
      first_profile.is_from_a_different_category?(second_profile) || first_profile.same_category_opposing_stage?(second_profile)
    end

    def tie_detected?(first_profile, second_profile, minimum_tie_probability)
      percentage_difference_between_two_profiles(first_profile, second_profile) < minimum_tie_probability
    end

    def percentage_difference_between_two_profiles(first_profile, second_profile)
      ( (first_profile.score - second_profile.score) / first_profile.score )
    end

    def initialize_profiles_scores_for_question(question)
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
      @profiles ||= Fondeso::Data::PROFILES.map { |profile| Profile.new(profile) }
    end
  end
end
