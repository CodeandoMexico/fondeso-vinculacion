FactoryGirl.define do
  factory :fund do
    sequence(:name) {|n| "name#{n}" }
    sequence(:friendly_id) {|n| "friendlyid#{n}" }
    sequence(:description) {|n| "description#{n}" }
    sequence(:institution) {|n| "institution#{n}" }
  end
end
