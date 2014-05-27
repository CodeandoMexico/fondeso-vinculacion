require 'spec_helper'

describe 'Questions' do
  describe 'with clear score' do
    [
      ['2.A.3', 'B', [0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, 0, 0, 0]],
      ['2.A.4', '1', [1, 0, -1, -1, 1, -1, -1, 0, -1, -1, 0, -1, -1, 0, -1, -1]],
      ['2.A.5', '10', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
      ['2.A.7', 'A', [-1, -1, -1, -1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1]],
      ['2.A.8', 'A', [1, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]],

      ['3.A.1', 20, [-1, -1, 0, 1, -1, 1, 1, -1, 0, 1, -1, 0, 1, -1, 0, 1]],
      ['3.A.2',
       { 'A' => false,
         'B' => false,
         'C' => true,
         'D' => true,
         'E' => false,
         'F' => false,
         'G' => true,
         'H' => true,
         'I' => true,
         'J' => false },
         [-7, -7, -1, 2, -4, -3, -3, -6, -6, -2, -6, -6, -2, -3, 0, 2]]

    ].each do |example|
      question_id = example.first
      answer = example.second
      score = example.third

      it "example: #{question_id}, #{answer}" do
        questionary = Fondeso::Questionary.new
        questionary.answer_question(question_id, answer)
        questionary.current_score.should eq score
      end
    end
  end
end
