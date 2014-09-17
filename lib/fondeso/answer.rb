require 'json'

module Fondeso
  class Answer
    attr_reader :answers

    def initialize
      # @questionary = Questionary.new
      @answers = Array.new
    end

    # Get the contents from the front end questions and instantiates it's objects
    def extract_question_data_from(sections)
      # let's parse the answer question to a readable format
      sections.each do |current_section|
        questions = current_section["questions"]
        questions.each do |q|
          # check for an answer
          answers.push << parse(q) # let's extract the info
        end
      end
    end

    def process_questionary
      questionary = Questionary.new
      answers.each do |ans|
          questionary.answer_question(ans[:id], ans[:answer])
      end
      # show information from partial/complete scores
      answers.each do |ans|
        Fondeso::Data::PROFILES.map do |e|
          score = questionary.profile_score_for_question(ans[:id], e[:profile_id])
          k = { id: ans[:id], profile: e[:name], score: score }
        end
      end
      # retrieve the winner profile to the controller
      questionary.winner_profile
    end

    protected
    def parse(question)
      parsed_answer = case question[:type]
        when "number"
          question[:body][:value]
        when "radio"
          question[:body][:selected_value].upcase
        when "checkbox"
          hashify(question[:body][:options], key="value", value="checked")
        when "select"
          question[:body][:selected_value][:value].upcase
        when "prioritize"
          hashify(question[:body][:options], label="value", value="priority")
      end
      { id: question[:id], type: question[:type], answer: parsed_answer }
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
