class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  store :questionary, accessors: [ :answers, :category, :filters, :priorities, :delegations, :number_of_recommended_funds, :profile_created_at, :profile_updated_at ], coder: JSON
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   validates_presence_of :name

   def has_answered_a_questionary?
      questionary.present?
   end

   def update_his_information(funds)
     current_number_of_funds = funds.count
     if profile_created_at && funds.count != number_of_recommended_funds
       update_attributes(profile_updated_at: Date.today, number_of_recommended_funds: funds.count)
     elsif profile_created_at.blank?
       update_attributes(profile_created_at: Date.today, profile_updated_at: Date.today, number_of_recommended_funds: funds.count)
     end
   end
end
