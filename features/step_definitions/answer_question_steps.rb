require_relative '../../lib/fondeso'

Given(/^an empty score$/) do
  @questionary = Fondeso::Questionary.new
end

When(/^I answer the sector question with "(.*?)"$/) do |selected_option|
  selected_option = selected_option.split("-").first.strip
  @questionary.answer_question("2.A.3", selected_option)
end

When(/^I answer the ordinal question "(.*?)" with:$/) do |question, answers_table|
  x = ordinal_answer(answers_table)
  puts "#{question} and #{x}"
  @questionary.answer_question(question, ordinal_answer(answers_table))
end

When(/^I answer the question "(.*?)" with the unique answer "(.*?)"$/) do |question, answer|
  puts "#{question} and #{answer}"
  @questionary.answer_question(question, answer)
end

When(/^I answer the multiple answer question "(.*?)" with:$/) do |question, answers_table|
  x = multiple_answer(answers_table)
  puts "#{question} and #{x}"
  @questionary.answer_question(question, multiple_answer(answers_table))
end

Then(/^my current score should be:$/) do |table|
  table.raw.to_h.each do |profile, score|
    # puts "----------"
    # puts profile
    profile_score_should_eq(profile, @questionary.current_profile_score(profile), score)
  end
end

Then(/^the partial score for the question "(.*?)" should be:$/) do |question, table|
  table.raw.to_h.each do |profile, score|
    profile_score_should_eq(profile, @questionary.profile_score_for_question(question, profile), score)
  end
end

def profile_score_should_eq(profile, profile_score, score)
  actual_score = (profile_score * 100).to_i / 100.0
  message = "Profile #{profile} should have score #{score.to_f} and got #{actual_score}"
  actual_score.should eq(score.to_f), message
end

def ordinal_answer(answers_table)
  answers_table.raw.to_h.inject({}) do |hash, (key, value)|
    hash[key] = value
    hash
  end
end

def multiple_answer(answers_table)
  answers_table.raw.to_h.inject({}) do |hash, (key, value)|
    hash[key] = value == 'x'
    hash
  end
end
