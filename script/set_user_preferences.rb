building_id = Building.first.id

for user in User.all
  pref = UserPreference.new({
                              user_id: user.id,
                              building_id: building_id
                            })
  pref.save
end
