class FondesoQuestionary
  PROFILES = [
    { name: "need-startup", profile_id: "ns" },
    { name: "traditional-startup", profile_id: "ts" },
    { name: "traditional-growing", profile_id: "tg" },
    { name: "traditional-consolidation", profile_id: "tc" },
    { name: "lifestyle-startup", profile_id: "ls" },
    { name: "lifestyle-growing", profile_id: "lg" },
    { name: "lifestyle-consolidation", profile_id: "lc" },
    { name: "cultural-startup", profile_id: "cs" },
    { name: "cultural-growing", profile_id: "cg" },
    { name: "cultural-consolidation", profile_id: "cc" },
    { name: "social-startup", profile_id: "ss" },
    { name: "social-growing", profile_id: "sg" },
    { name: "social-consolidation", profile_id: "sc" },
    { name: "high_impact-startup", profile_id: "hs" },
    { name: "high_impact-growing", profile_id: "hg" },
    { name: "high_impact-consolidation", profile_id: "hc" }
  ]

  QUESTIONS = [
    {
      'question_id' => '2.A.1',
      'type' => 'ordinal',
      'associations' => {
        'positive' => {
          'A' => ['ns'],
          'B' => ['ts', 'tg', 'tc'],
          'C' => ['ss', 'sg', 'sc'],
          'D' => ['cs', 'cg', 'cc'],
          'E' => ['ls', 'lg', 'lc'],
          'F' => ['hs', 'hg', 'hc']
        }
      }
    },
    {
      'question_id' => '2.A.2',
      'type' => 'ordinal',
      'associations' => {
        'positive' => {
          'A' => ['ns'],
          'B' => ['ts', 'tg', 'tc'],
          'C' => ['ls', 'lg', 'lc'],
          'D' => ['cs', 'cg', 'cc'],
          'E' => ['ss', 'sg', 'sc'],
          'F' => ['hs', 'hg', 'hc']
        }
      }
    },

    {
      'question_id' => '2.A.3',
      'type' => 'unique',
      'associations' => {
        'positive' => {
          'E' => ['cs', 'cg', 'cc'],
          'F' => ['ss', 'sg', 'sc'],
          'H' => ['hs', 'hg', 'hc']
        },
        'negative' => {
          'A' => ['ns', 'ls', 'lg', 'lc', 'cs', 'cg', 'cc'],
          'B' => ['cs', 'cg', 'cc', 'ss', 'sg', 'sc'],
          'C' => ['cs', 'cg', 'cc', 'ss', 'sg', 'sc'],
          'D' => ['ns'],
          'E' => ['ns', 'ts', 'tg', 'tc'],
          'F' => ['ns', 'ts', 'tg', 'tc', 'ls', 'lg', 'lc'],
          'G' => ['ls', 'lg', 'lc', 'cs', 'cg', 'cc'],
          'H' => ['ns', 'ts', 'tg', 'tc', 'cs', 'cg', 'ss', 'sg', 'sc']
        }
      }
    }
  ]

  attr_reader :profiles, :questions

  def initialize
    @profiles  = Profiles.new
  end

  def self.start
    new
  end

  def answer_question(question_id, answer)
    question = Question.find(question_id)
    question.add_points_for_answer(answer, profiles)
  end

  def current_profile_score(profile_name)
    profiles.find(profile_name).score
  end

  class Question
    attr_reader :type

    def initialize(data)
      @type = data.fetch('type')
      @associations = data.fetch('associations')
    end

    def self.find(question_id)
      build_type all_questions.fetch(question_id)
    end

    def positive_associations_for(item)
      associations.fetch('positive', {}).fetch(item, [])
    end

    def negative_associations_for(item)
      associations.fetch('negative', {}).fetch(item, [])
    end

    private

    attr_reader :associations

    def self.build_type(question_data)
      case question_data.fetch('type')
      when 'ordinal' then OrdinalQuestion.new(question_data)
      when 'unique' then UniqueQuestion.new(question_data)
      end
    end

    def self.all_questions
      QUESTIONS.inject({}) do |hash, question|
        hash[question.fetch('question_id')] = question
        hash
      end
    end
  end

  class OrdinalQuestion < Question
    def add_points_for_answer(answer, profiles)
      answer.each do |item, value|
        positive_associations_for(item).each do |profile_id|
          profiles.add_to_profile_score(profile_id, 1.0 / value)
        end
      end
    end
  end

  class UniqueQuestion < Question
    def add_points_for_answer(answer, profiles)
      negative_associations_for(answer).each do |profile_id|
        profiles.add_to_profile_score(profile_id, -1)
      end

      positive_associations_for(answer).each do |profile_id|
        profiles.add_to_profile_score(profile_id, 1)
      end
    end
  end

  class Profiles
    def initialize
      @all = PROFILES.map { |profile| Profile.new(profile) }
    end

    def find(name_or_profile_id)
      all.select { |profile| profile.identifiable_by?(name_or_profile_id) }.first
    end

    def add_to_profile_score(profile_id, points)
      find(profile_id).add_to_score(points)
    end

    private

    attr_reader :all
  end

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

Given(/^an empty score$/) do
  @questionary = FondesoQuestionary.start
end

When(/^I answer the ordinal question "(.*?)" with:$/) do |question, answers_table|
  @questionary.answer_question(question, ordinal_answer(answers_table))
end

When(/^I answer the question "(.*?)" with the unique answer "(.*?)"$/) do |question, answer|
  @questionary.answer_question(question, answer)
end

Then(/^my current score should be:$/) do |table|
  table.raw.to_h.each { |profile, score| profile_score_should_eq(@questionary, profile, score) }
end

def profile_score_should_eq(questionary, profile, score)
  actual_score = (questionary.current_profile_score(profile) * 100).to_i / 100.0
  actual_score.should eq(score.to_f), "Profile #{profile} should have score #{score.to_f} and got #{actual_score}"
end

def ordinal_answer(answers_table)
  answers_table.raw.to_h.inject({}) do |hash, (key, value)|
    hash[key] = value.to_f
    hash
  end
end
