class FondesoQuestionary
  class Sector
    attr_reader :sector_id

    def initialize(sector_id)
      @sector_id = sector_id
    end

    def self.defined_in_question?(question_id)
      question_id == '2.A.3'
    end

    def == sector
      sector.is_a?(self.class) &&
        sector.sector_id == sector_id
    end
  end
end
