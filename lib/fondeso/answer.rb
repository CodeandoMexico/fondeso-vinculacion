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
      sections.each do |current_section|
        questions = current_section["questions"]
        questions.each do |q|
          # check for an answer
          current_answer = { id: q["id"], title: q["title"], body: q["body"] }
          puts current_answer[:id]
          answers.push current_answer
        end
      end

    end

    # protected
    # def extract_question_data(question)
    #
    # end

  end
end
