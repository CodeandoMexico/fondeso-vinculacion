require_relative '../../lib/fondeso'

Given(/^an empty score$/) do
  @questionary = Fondeso::Questionary.new
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

When(/^I answer the multiple answer question "(.*?)" with:$/) do |question, answers_table|
  @questionary.answer_question(question, multiple_answer(answers_table))
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

def multiple_answer(answers_table)
  answers_table.raw.to_h.inject({}) do |hash, (key, value)|
    hash[key] = value == 'x'
    hash
  end
end
