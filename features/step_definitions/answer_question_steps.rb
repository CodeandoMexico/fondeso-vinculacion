class FondesoQuestionary
  PROFILE_NAMES = ["need-startup", "traditional-startup", "traditional-growing",
   "traditional-consolidation", "lifestyle-startup", "lifestyle-growing",
   "lifestyle-consolidation", "cultural-startup", "cultural-growing",
   "cultural-consolidation", "social-startup", "social-growing",
   "social-consolidation", "high_impact-startup", "high_impact-growing",
   "high_impact-consolidation"]

  attr_reader :profiles

  def initialize
    @profiles = PROFILE_NAMES.map { |profile_name| Profile.new(profile_name) }
  end

  def self.start
    new
  end

  def answer_question(question, answer)
    answer_ordinal_question(question, answer)
  end

  def current_profile_score(profile_name)
    profile_with_name(profile_name).score
  end

  private

  def profile_with_name(name)
    profiles.select { |profile| profile.name == name }.first
  end

  def answer_ordinal_question(question, answers)
    questions = {
      '2.A.1' => {
        'A' => ["need-startup"],
        'B' => ["traditional-startup", "traditional-growing", "traditional-consolidation"],
        'C' => ["social-startup", "social-growing", "social-consolidation"],
        'D' => ["cultural-startup", "cultural-growing", "cultural-consolidation"],
        'E' => ["lifestyle-startup", "lifestyle-growing", "lifestyle-consolidation"],
        'F' => ["high_impact-startup", "high_impact-growing", "high_impact-consolidation"]
      },

      '2.A.2' => {
        'A' => ["need-startup"],
        'B' => ["traditional-startup", "traditional-growing", "traditional-consolidation"],
        'C' => ["lifestyle-startup", "lifestyle-growing", "lifestyle-consolidation"],
        'D' => ["cultural-startup", "cultural-growing", "cultural-consolidation"],
        'E' => ["social-startup", "social-growing", "social-consolidation"],
        'F' => ["high_impact-startup", "high_impact-growing", "high_impact-consolidation"]
      }
    }
    answers.each do |item, value|
      questions[question][item].each do |profile|
        profile_with_name(profile).add_to_score(1.0 / value)
      end
    end
  end

  class Profile
    attr_reader :name, :score

    def initialize(name)
      @name = name
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

Then(/^my current score should be:$/) do |table|
  table.raw.to_h.each do |profile, score|
    actual_score = (@questionary.current_profile_score(profile) * 100).to_i / 100.0
    actual_score.should eq(score.to_f), "Profile #{profile} should have score #{score.to_f} and got #{actual_score}"
  end
end

def ordinal_answer(answers_table)
  answers_table.raw.to_h.inject({}) do |hash, (key, value)|
    hash[key] = value.to_f
    hash
  end
end
