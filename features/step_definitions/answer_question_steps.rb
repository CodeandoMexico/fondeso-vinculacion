class FondesoQuestionary
  PROFILES = [
    { name: "need-startup", short: "ns" },
    { name: "traditional-startup", short: "ts" },
    { name: "traditional-growing", short: "tg" },
    { name: "traditional-consolidation", short: "tc" },
    { name: "lifestyle-startup", short: "ls" },
    { name: "lifestyle-growing", short: "lg" },
    { name: "lifestyle-consolidation", short: "lc" },
    { name: "cultural-startup", short: "cs" },
    { name: "cultural-growing", short: "cg" },
    { name: "cultural-consolidation", short: "cc" },
    { name: "social-startup", short: "ss" },
    { name: "social-growing", short: "sg" },
    { name: "social-consolidation", short: "sc" },
    { name: "high_impact-startup", short: "hs" },
    { name: "high_impact-growing", short: "hg" },
    { name: "high_impact-consolidation", short: "hc" }
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

  attr_reader :profiles

  def initialize
    @profiles = Profiles.new
  end

  def self.start
    new
  end

  def answer_question(question_id, answer)
    case question_with_id(question_id).fetch('type')
    when 'ordinal' then answer_ordinal_question(question_id, answer)
    when 'unique' then answer_unique_question(question_id, answer)
    end
  end

  def current_profile_score(profile_name)
    profiles.find_with(profile_name).score
  end

  private

  def answer_ordinal_question(question_id, answers)
    answers.each do |item, value|
      positive_associations_for(question_id).fetch(item).each do |profile_short|
        profiles.find_with(profile_short).add_to_score(1.0 / value)
      end
    end
  end

  def answer_unique_question(question_id, answer)
    negative_associations_for(question_id).fetch(answer, []).each do |profile_short|
      profiles.find_with(profile_short).add_to_score(-1)
    end

    positive_associations_for(question_id).fetch(answer, []).each do |profile_short|
      profiles.find_with(profile_short).add_to_score(1)
    end
  end

  def positive_associations_for(question_id)
    question_with_id(question_id).fetch('associations').fetch('positive', {})
  end

  def negative_associations_for(question_id)
    question_with_id(question_id).fetch('associations').fetch('negative', {})
  end

  def question_with_id(question_id)
    QUESTIONS.select { |question| question.fetch('question_id') == question_id }.first
  end

  class Profiles
    attr_reader :all
    def initialize
      @all = PROFILES.map { |profile| Profile.new(profile) }
    end

    def find_with(name_or_short)
      all.select do |profile|
        profile.name == name_or_short ||
          profile.short == name_or_short
      end.first
    end
  end

  class Profile
    attr_reader :name, :short, :score

    def initialize(args)
      @name  = args.fetch(:name)
      @short = args.fetch(:short)
      @score = 0
    end

    def add_to_score(amount)
      self.score = score + amount
    end

    private

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
