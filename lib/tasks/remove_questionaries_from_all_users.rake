task remove_questionary_from_all_users: :environment do
  User.all.each do |u|
    u.update_attributes(questionary: nil)
  end
end
