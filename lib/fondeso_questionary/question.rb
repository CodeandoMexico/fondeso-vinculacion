class FondesoQuestionary
  class Question
    attr_reader :type

    def initialize(data)
      @type = data.fetch('type')
      @question_id = data.fetch('question_id')
      @associations = data.fetch('associations')
    end

    def self.find(question_id)
      build_type all_questions.fetch(question_id)
    end

    def positive_associations_for_option(option)
      associations.fetch('positive', {}).fetch(option, [])
    end

    def negative_associations_for_option(option)
      associations.fetch('negative', {}).fetch(option, [])
    end

    private

    attr_reader :associations, :question_id

    def self.build_type(question_data)
      case question_data.fetch('type')
      when 'unique' then UniqueQuestion.new(question_data)
      when 'ordinal' then OrdinalQuestion.new(question_data)
      when 'unique_with_range_and_sector' then UniqueWithRangeAndSectorQuestion.new(question_data)
      end
    end

    def self.all_questions
      FONDESO_QUESTIONS.inject({}) do |hash, question|
        hash[question.fetch('question_id')] = question
        hash
      end
    end
  end
end
