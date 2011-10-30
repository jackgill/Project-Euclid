# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def add_user(name)
  user = User.new
  user.first_name = name
  user.last_name = 'LNU'
  user.email = name + '@example.com'
  user.login = name
  user.password = name
  user.save()
  return user.id
end

def add_building(name, address)
  building = Building.new
  building.name = name
  building.address = address
  building.save()
  return building.id
end

def add_spot(building_id, number, floor, owner_id)
  spot = Spot.new
  spot.building_id = building_id
  spot.number = number
  spot.floor = floor
  spot.owner_id = owner_id
  spot.save()
  return spot.id
end

bob = add_user('bob')
alice = add_user('alice')
eve = add_user('eve')

timber_ridge = add_building('Timber Ridge', '2980 Euclid Ave., Boulder, CO 80303')
spire = add_building('The Spire', 'Somewhere around 15th and Champa')

add_spot(timber_ridge, 1, 1, bob)
add_spot(spire, 9, 37, alice)
