require_relative 'fondeso/data'

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
      business.add_answer(question_id, answer)
      question.add_points_for_answer(answer, business)
    end

    def current_profile_score(profile_id)
      business.current_profile_score(profile_id)
    end
  end
end
