module Fondeso
  class Profile
    def initialize(args)
      @name  = args.fetch(:name)
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

    private

    attr_reader :name, :profile_id
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
