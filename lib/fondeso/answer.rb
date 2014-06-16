require 'json'

module Fondeso
  class Answer
    attr_reader :answers

    def initialize
      @questionary = Questionary.new
      @answers = Array.new
    end

    # Get the contents from the front end questions and instantiates it's objects
    def extract_question_data_from(sections)
      # puts sections
      # let's parse the answer question to a readable format
      sections.each do |current_section|
        questions = current_section["questions"]
        questions.each do |q|
          # check for an answer
          tmp = { id: q["id"], type: q["type"], body: q["body"] }
          parsed_answer = parse tmp # let's extract the info
          puts parsed_answer
          answers.push parsed_answer
        end
      end
    end

    def process_questionary
      answers.each do |ans|
          questionary.answer_question(ans.id)
      end
    end

    protected
    def parse(question)
      answer = case question[:type]
        when "number"
          # puts "---number---"
          question[:body][:value]
        when "radio"
          # puts "---radio---"
          question[:body][:selected_value].upcase
        when "checkbox"
          # puts "---checkbox---"
          checked = hashify(question[:body][:options], label="value", value="checked")
        when "select"
          # puts "---select---"
          question[:body][:selected_value][:label]
        when "prioritize"
          # puts "---prioritize---"
          # priorities = question[:body][:options].map { |option| option[:priority] }
          priorities = hashify(question[:body][:options], label="value", value="priority")
      end
    end

    def hashify(elements, label, value)
      new_hash = elements.inject({}) do |hash, e|
        key = e[label].upcase
        hash[key] = e[value]
        hash
      end
      new_hash
    end
  end
end
