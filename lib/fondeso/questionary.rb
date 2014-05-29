module Fondeso
  class Questionary
    attr_reader :user

    def initialize
      @user = User.new
    end

    def answer_question(question_id, answer)
      if Sector.defined_in_question?(question_id)
        user.business_sector = Sector.new(answer)
      end

      question = Question.find(question_id)
      user.answer_question(question, answer)
    end

    def current_profile_score(profile_id)
      user.current_profile_score(profile_id)
    end

    def profile_score_for_question(question_id, profile_id)
      question = Question.find(question_id)
      user.profile_score_for_question(question, profile_id)
    end

    def current_score
      user.current_score
    end
  end
end
