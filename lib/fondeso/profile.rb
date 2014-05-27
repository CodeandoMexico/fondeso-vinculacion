module Fondeso
  class Profile
    attr_reader :score

    def initialize(args)
      @name  = args.fetch(:name)
      @profile_id = args.fetch(:profile_id)
      @score = 0
    end

    def identifiable_by?(identifier)
      name == identifier || profile_id == identifier
    end

    def add_to_score(amount)
      self.score = score + amount
    end

    private

    attr_reader :name, :profile_id
    attr_writer :score
  end
end
