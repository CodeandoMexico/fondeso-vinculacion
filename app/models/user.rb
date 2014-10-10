class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  store :questionary, accessors: [ :answers, :category, :filters, :priorities, :delegations ], coder: JSON
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   validates_presence_of :name
end
