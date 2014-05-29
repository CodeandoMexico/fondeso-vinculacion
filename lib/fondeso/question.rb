module Fondeso
  class Question
    attr_reader :type, :question_id

    def initialize(data)
      @type = data.fetch('type')
      @question_id = data.fetch('question_id')
      @associations = data.fetch('associations', {})
    end

    def self.find(question_id)
      build_type all_questions.fetch(question_id)
    end

    def positive_associations
      associations.fetch('positive')
    end

    def negative_associations
      associations.fetch('negative')
    end

    def positive_associations_for_option(option, *other_params)
      positive_associations.select do |key|
        match_associations_key?(key, option, *other_params)
      end.values.first || :not_matched_key
    end

    def negative_associations_for_option(option, *other_params)
      negative_associations.select do |key|
        match_associations_key?(key, option, *other_params)
      end.values.first || :not_matched_key
    end

    private

    attr_reader :associations

    def add_points_to_profile(business, profile_id, points)
      business.add_to_profile_score(profile_id, self, points)
    end

    def match_associations_key?(key, option, *other_params)
      key === option
    end

    def self.build_type(question_data)
      "Fondeso::Questions::#{question_data.fetch('type').camelize}Question".constantize.new(question_data)
    end

    def self.all_questions
      Fondeso::Data::QUESTIONS.inject({}) do |hash, question|
        hash[question.fetch('question_id')] = question
        hash
      end
    end
  end
end
