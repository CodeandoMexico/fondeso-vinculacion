class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  store :questionary, accessors: [ :answers, :category, :filters, :priorities, :delegations, :number_of_recommended_funds, :profile_created_at, :profile_updated_at ], coder: JSON
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   validates_presence_of :name

  def self.total
    all.count
  end

  def has_a_saved_questionary?
    questionary.present?
  end

  def has_answered_a_questionary?
    profile_created_at.present?
  end

  def self.total_answered_questionaries
    all.select{ |u| u.has_answered_a_questionary? }.count
  end

  def update_his_information(funds)
   current_number_of_funds = funds.count
   if profile_created_at && funds.count != number_of_recommended_funds
     update_attributes(profile_updated_at: Date.today, number_of_recommended_funds: funds.count)
   elsif profile_created_at.blank?
     update_attributes(profile_created_at: Date.today, profile_updated_at: Date.today, number_of_recommended_funds: funds.count)
   end
  end

  def to_a
   current = [name, email]
   if has_answered_a_questionary?
     current.push(
       delegations[:home],
       delegations[:business],
       category[:uri],
       number_of_recommended_funds,
       profile_created_at,
       profile_updated_at
     )
   else
     current.push( nil, nil, nil, nil, nil, nil )
   end
  end

  def self.to_csv
   CSV.generate do |csv|

     csv << export_headers
     all.each do |user|
       csv << user.to_a
     end
   end
  end

  private
   def self.export_headers
     [
      "Nombre",
      "Email",
      "Delegación domicilio",
      "Delegación negocio",
      "Perfil",
      "Número de fondos recomendado",
      "Fecha de creación de cuestionario",
      "Fecha de actualización de cuestionario"
     ]
   end
end
