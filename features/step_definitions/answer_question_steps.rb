class FondesoQuestionary
  PROFILES = [
    { name: "need-startup", profile_id: "n1" },
    { name: "traditional-startup", profile_id: "t1" },
    { name: "traditional-growing", profile_id: "t2" },
    { name: "traditional-consolidation", profile_id: "t3" },
    { name: "lifestyle-startup", profile_id: "l1" },
    { name: "lifestyle-growing", profile_id: "l2" },
    { name: "lifestyle-consolidation", profile_id: "l3" },
    { name: "cultural-startup", profile_id: "c1" },
    { name: "cultural-growing", profile_id: "c2" },
    { name: "cultural-consolidation", profile_id: "c3" },
    { name: "social-startup", profile_id: "s1" },
    { name: "social-growing", profile_id: "s2" },
    { name: "social-consolidation", profile_id: "s3" },
    { name: "high_impact-startup", profile_id: "h1" },
    { name: "high_impact-growing", profile_id: "h2" },
    { name: "high_impact-consolidation", profile_id: "h3" }
  ]

  QUESTIONS = [
    {
      'question_id' => '2.A.1',
      'type' => 'ordinal',
      'associations' => {
        'positive' => {
          'A' => ['n1'],
          'B' => ['t1', 't2', 't3'],
          'C' => ['s1', 's2', 's3'],
          'D' => ['c1', 'c2', 'c3'],
          'E' => ['l1', 'l2', 'l3'],
          'F' => ['h1', 'h2', 'h3']
        }
      }
    },
    {
      'question_id' => '2.A.2',
      'type' => 'ordinal',
      'associations' => {
        'positive' => {
          'A' => ['n1'],
          'B' => ['t1', 't2', 't3'],
          'C' => ['l1', 'l2', 'l3'],
          'D' => ['c1', 'c2', 'c3'],
          'E' => ['s1', 's2', 's3'],
          'F' => ['h1', 'h2', 'h3']
        }
      }
    },

    {
      'question_id' => '2.A.3',
      'type' => 'unique',
      'associations' => {
        'positive' => {
          'E' => ['c1', 'c2', 'c3'],
          'F' => ['s1', 's2', 's3'],
          'H' => ['h1', 'h2', 'h3']
        },
        'negative' => {
          'A' => ['n1', 'l1', 'l2', 'l3', 'c1', 'c2', 'c3'],
          'B' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
          'C' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
          'D' => ['n1'],
          'E' => ['n1', 't1', 't2', 't3'],
          'F' => ['n1', 't1', 't2', 't3', 'l1', 'l2', 'l3'],
          'G' => ['l1', 'l2', 'l3', 'c1', 'c2', 'c3'],
          'H' => ['n1', 't1', 't2', 't3', 'c1', 'c2', 's1', 's2', 's3']
        }
      }
    },

    {
      'question_id' => '2.A.4',
      'type' => 'unique_with_range_and_sector',
      'associations' => {
        'positive' => {
          { 'range' => 1 } => ['n1', 'l1'],
          { 'range' => 11..30,  'sector' => 'B' } => ['t2'],
          { 'range' => 11..50,  'except_sector' => 'B' } => ['t2'],
          { 'range' => 51..100, 'except_sector' => 'B' } => ['t2'],
          { 'range' => 100..Float::INFINITY } => ['t3', 'h3']
        },
        'negative' => {
          { 'range' => 1 } => ['t2', 't3', 'l2', 'l3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
          { 'range' => 11..30,  'sector' => 'B' } => ['n1', 't3', 'l1', 'l2', 'l3', 'c1', 's1', 'h1', 'h3'],
          { 'range' => 11..50,  'except_sector' => 'B' } => ['n1', 't3', 'l1', 'c1', 's1', 'h1', 'h3'],
          { 'range' => 51..100, 'except_sector' => 'B' } => ['n1', 't1', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1'],
          { 'range' => 100..Float::INFINITY } => ['n1', 't1', 't2', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1', 'h2']
        }
      }
    }
  ]

  SECTORS = [
    { 'sector_id' => 'A', 'display' => 'Industrias manufactureras' },
    { 'sector_id' => 'B', 'display' => 'Comercio' },
    { 'sector_id' => 'C', 'display' => 'Preparación de alimentos y hoteles' },
    { 'sector_id' => 'D', 'display' => 'Servicios varios' },
    { 'sector_id' => 'E', 'display' => 'Culturales y de esparcimiento, deportivos y recreativos' },
    { 'sector_id' => 'F', 'display' => 'Organizaciones con fines de altruistas y medio ambiente' },
    { 'sector_id' => 'G', 'display' => 'Agricultura, ganadería, aprovechamiento forestal' },
    { 'sector_id' => 'H', 'display' => 'Tecnologías de la información y la comunicación' },
    { 'sector_id' => 'I', 'display' => 'Otros' },
    { 'sector_id' => 'J', 'display' => 'No sé' },
  ]

  attr_reader :business

  def initialize
    @business = Business.new
  end

  def self.start
    new
  end

  def answer_question(question_id, answer)
    if Sector.defined_in_question?(question_id)
      business.sector = Sector.new(answer)
    end

    question = Question.find(question_id)
    question.add_points_for_answer(answer, business)
  end

  def current_profile_score(profile_id)
    business.current_profile_score(profile_id)
  end

  class Sector
    attr_reader :sector_id

    def initialize(sector_id)
      @sector_id = sector_id
    end

    def self.defined_in_question?(question_id)
      question_id == '2.A.3'
    end

    def == sector
      sector.is_a?(self.class) &&
        sector.sector_id == sector_id
    end
  end

  class Question
    attr_reader :type

    def initialize(data)
      @type = data.fetch('type')
      @question_id = data.fetch('question_id')
      @associations = data.fetch('associations')
    end

    def self.find(question_id)
      build_type all_questions.fetch(question_id)
    end

    def positive_associations_for_option(option)
      associations.fetch('positive', {}).fetch(option, [])
    end

    def negative_associations_for_option(option)
      associations.fetch('negative', {}).fetch(option, [])
    end

    private

    attr_reader :associations, :question_id

    def self.build_type(question_data)
      case question_data.fetch('type')
      when 'unique' then UniqueQuestion.new(question_data)
      when 'ordinal' then OrdinalQuestion.new(question_data)
      when 'unique_with_range_and_sector' then UniqueWithRangeAndSectorQuestion.new(question_data)
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
    def add_points_for_answer(answer, business)
      answer.each do |option, value|
        positive_associations_for_option(option).each do |profile_id|
          business.add_to_profile_score(profile_id, 1.0 / value)
        end
      end
    end
  end

  class UniqueQuestion < Question
    def add_points_for_answer(selected_option, business)
      negative_associations_for_option(selected_option).each do |profile_id|
        business.add_to_profile_score(profile_id, -1)
      end

      positive_associations_for_option(selected_option).each do |profile_id|
        business.add_to_profile_score(profile_id, 1)
      end
    end
  end

  class UniqueWithRangeAndSectorQuestion < UniqueQuestion
    def add_points_for_answer(selected_option, business)
      negative_associations_for_option_and_business(selected_option, business).each do |profile_id|
        business.add_to_profile_score(profile_id, -1)
      end

      positive_associations_for_option_and_business(selected_option, business).each do |profile_id|
        business.add_to_profile_score(profile_id, 1)
      end
    end

    private

    def positive_associations_for_option_and_business(selected_option, business)
      associations.fetch('positive').select do |key_with_range_and_sector|
        match_associations_key(key_with_range_and_sector, selected_option, business)
      end.values.first || :not_matched_key
    end

    def negative_associations_for_option_and_business(selected_option, business)
      associations.fetch('negative').select do |key_with_range_and_sector|
        match_associations_key(key_with_range_and_sector, selected_option, business)
      end.values.first || :not_matched_key
    end

    def match_associations_key(key, selected_option, business)
      range, sector, except_sector = key.values_at('range', 'sector', 'except_sector')

      range === selected_option.to_i &&
        (sector.nil? && except_sector.nil? ||
         sector.present? && except_sector.nil? && business.sector == Sector.new(sector) ||
         sector.nil? && except_sector.present? && business.sector != Sector.new(except_sector))
    end
  end

  class Business
    attr_accessor :sector

    def find_profile(name_or_profile_id)
      profiles.select { |profile| profile.identifiable_by?(name_or_profile_id) }.first
    end

    def current_profile_score(profile_id)
      find_profile(profile_id).score
    end

    def add_to_profile_score(profile_id, points)
      find_profile(profile_id).add_to_score(points)
    end

    private

    def profiles
      @profiles ||= PROFILES.map { |profile| Profile.new(profile) }
    end
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

When(/^I answer the sector question with "(.*?)"$/) do |selected_option|
  selected_option = selected_option.split("-").first.strip
  @questionary.answer_question("2.A.3", selected_option)
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
