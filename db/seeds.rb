require 'date'

# Wipe the resources tables
# Note: order matters due to foreign key constraints
Availability.delete_all
Listing.delete_all
Transaction.delete_all
Spot.delete_all
Building.delete_all
Request.delete_all
User.delete_all
UserPreference.delete_all

# Utility methods to add new resources objects
def add_user(name, is_admin, building_id, notify_new_request= false, notify_new_listing=false, email=nil)
  user_id = User.create(
              first_name: name,
              last_name: 'LNU',
              email: email == nil ? name + '@example.com' : email,
              login: name,
              password: 'foo',
              is_admin: is_admin,
              ).id
  UserPreference.create(
                        building_id: building_id,
                        user_id: user_id,
                        notify_new_request: notify_new_request,
                        notify_new_listing: notify_new_listing
                        )
  return user_id
end

def add_building(name, address)
  Building.create(
                  name: name,
                  address: address,
                  ).id
end

def add_spot(building_id, number, floor, owner_id)
  Spot.create(
              building_id: building_id,
              number: number,
              floor: floor,
              owner_id: owner_id,
              ).id
end

def add_transaction(spot_id, buyer_id, seller_id, start_date, end_date, price)
  Transaction.create(
                     spot_id: spot_id,
                     buyer_id: buyer_id,
                     seller_id: seller_id,
                     start_date: start_date,
                     end_date: end_date,
                     price: price,
                     ).id
end

timber_ridge = add_building('Timber Ridge', '2980 Euclid Ave., Boulder, CO 80303')
spire = add_building('The Spire', 'Somewhere around 15th and Champa')

# Add the seed data
bob = add_user('bob', false, timber_ridge)
alice = add_user('alice', false, spire)
eve = add_user('eve', false, spire)
jack = add_user('jack', true, timber_ridge, true, true, 'jack@jackmgill.com')
justin = add_user('justin', true, spire)


spot1 = add_spot(timber_ridge, 1, 1, bob)
spot2 = add_spot(spire, 9, 37, alice)

add_transaction(spot2, bob, alice, Date.today, Date.today + 1, 10)
