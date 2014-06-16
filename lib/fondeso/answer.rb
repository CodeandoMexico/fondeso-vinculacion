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
      # puts sections
      # let's parse the answer question to a readable format
      sections.each do |current_section|
        questions = current_section["questions"]
        questions.each do |q|
          # check for an answer
          # tmp = { id: q["id"], type: q["type"], body: q["body"] }
          ans = parse q # let's extract the info
          puts ans
          answers.push ans
        end
      end
    end

    def process_questionary
      questionary = Questionary.new
      answers.each do |ans|
          questionary.answer_question(ans[:id], ans[:answer])
          # questionary.profile_score_for_question(ans[:id], ans[:answer])
      end
      answers.each do |ans|
        Fondeso::Data::PROFILES.map do |e|
          score = questionary.profile_score_for_question(ans[:id], e[:profile_id])
          k = { id: ans[:id], profile: e[:name], score: score }
          puts k
        end
        puts ""
      end
      puts "------ final score ------"
      Fondeso::Data::PROFILES.map do |e|
        s = questionary.current_profile_score(e[:name])
        k = { id: e[:name], score: s }
        puts k
      end
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
          # priorities = question[:body][:options].map { |option| option[:priority] }
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
