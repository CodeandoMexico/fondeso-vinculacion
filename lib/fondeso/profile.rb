module Fondeso
  class Profile
    attr_reader :name, :uri, :profile_id
    def initialize(args)
      @name  = args.fetch(:name)
      @uri  = args.fetch(:uri)
      @profile_id = args.fetch(:profile_id)
      @scores = Scores.new
    end

    def identifiable_by?(identifier)
      name == identifier || profile_id == identifier
    end

    def add_to_score(question, points)
      scores.add(question, points)
    end

    def score
      scores.sum
    end

    def score_for_question(question)
      scores[question]
    end

    def initialize_score_for_question(question)
      scores.initialize_for_question(question)
    end

    def is_from_a_different_category?(another_profile)
      profile_id.first != another_profile.profile_id.first
    end

    def same_category_opposing_stage?(another_profile)
      profile_id.first == another_profile.profile_id.first &&
      Integer(profile_id.last) + Integer(another_profile.profile_id.last) == 4 # math trick start-up = 1, consolidation = 3
    end

    private

    attr_reader :scores

    class Scores
      def initialize
        @all = {}
      end

      def initialize_for_question(question)
        all[question.question_id] = 0
      end

      def add(question, points)
        all[question.question_id] += points
      end

      def sum
        all.values.sum
      end

      def [] question
        all.fetch(question.question_id) { 0 }
      end

      private

      attr_reader :all
    end
  end
end
