require 'json'

module Fondeso
  class Answer
    attr_reader :answers

    def initialize
      @answers = Array.new
    end

    def parse(sections)
      # puts sections
      # let's parse the answer question to a readable format
      keys = sections.except(:action, :controller, :fund).keys
      # puts keys
      keys.each do |k|
        current_section = sections[k.to_s] # get current section
        questions = current_section["questions"] # questions from the current section
        questions.each do |q|
          # create an answer hash for further processing
          current_answer = { title: q["title"], body: q["body"] }
          # puts current_answer
          answers.push current_answer
        end
      end

      puts answers

    end

    # protected
    # def extract_question_data(question)
    #
    # end

  end
end
