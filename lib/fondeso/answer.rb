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
          tmp = { id: q["id"], type: q["type"], body: q["body"] }
          current_answer = extract_question_data_from tmp # let's extract the info
          puts current_answer
          answers.push current_answer
        end
      end

    end

    protected
    def extract_question_data_from(question)
      answer = case question[:type]
        when "number"
          puts "---number---"
          question[:body][:value]
        when "radio"
          puts "---radio---"
          question[:body][:selected_value]
        when "checkbox"
          puts "---checkbox---"
          checked = question[:body][:options].select { |option| option[:checked] == true }
          checked.map { |option| option[:value] }
        when "select"
          puts "---select---"
          question[:body][:selected_value][:label]
        when "prioritize"
          puts "---prioritize---"
          priorities = question[:body][:options].map { |option| option[:priority] }
      end
    end

  end
end
