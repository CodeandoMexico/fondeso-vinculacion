module Fondeso
  class Questionary
    attr_reader :business

    def initialize
      @business = Business.new
    end

    def answer_question(question_id, answer)
      if Sector.defined_in_question?(question_id)
        business.sector = Sector.new(answer)
      end

      question = Question.find(question_id)
      business.answer_question(question, answer)
    end

    def current_profile_score(profile_id)
      business.current_profile_score(profile_id)
    end

    def profile_score_for_question(question_id, profile_id)
      question = Question.find(question_id)
      business.profile_score_for_question(question, profile_id)
    end

    def current_score
      business.current_score
    end
  end
end
