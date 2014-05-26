require_relative 'fondeso_questionary/data'
require_relative 'fondeso_questionary/sector'
require_relative 'fondeso_questionary/question'
require_relative 'fondeso_questionary/questions/ordinal_question'
require_relative 'fondeso_questionary/questions/unique_question'
require_relative 'fondeso_questionary/questions/unique_with_range_and_sector_question'
require_relative 'fondeso_questionary/profile'
require_relative 'fondeso_questionary/business'

class FondesoQuestionary
  attr_reader :business

  def initialize
    @business = Business.new
  end

  def self.start
    new
  end

  def answer_question(question_id, answer)
    if Sector.defined_in_question?(question_id)
      business.sector = Sector.new(answer)
    end

    question = Question.find(question_id)
    question.add_points_for_answer(answer, business)
  end

  def current_profile_score(profile_id)
    business.current_profile_score(profile_id)
  end
end
