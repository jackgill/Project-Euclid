require 'date'

# Wipe the resources tables
# Note: order matters due to foreign key constraints
Availability.delete_all
Listing.delete_all
Transaction.delete_all
Spot.delete_all
Request.delete_all
User.delete_all
Building.delete_all

# Utility methods to add new resources objects
def add_user(name, is_admin, building_id, notify_new_request= false, notify_new_listing=false)
  user_id = User.create(
                        first_name: name,
                        last_name: 'LNU',
                        email: 'jack+' + name + '@jackmgill.com',
                        password: 'foo',
                        is_admin: is_admin,
                        building_id: building_id,
                        notify_new_request: notify_new_request,
                        notify_new_listing: notify_new_listing
                        ).id
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

def add_listing(lister_id, building_id, spot_id, start_date, end_date, ask_price)

end

def add_availability(listing_id, building_id, start_date, end_date)

end

def add_transaction(building_id, spot_id, buyer_id, seller_id, start_date, end_date, price)
  # Create the listing
  listing_id = Listing.create(
                              lister_id: seller_id,
                              building_id: building_id,
                              spot_id: spot_id,
                              start_date: start_date,
                              end_date: end_date,
                              ask_price: price
                              ).id
  
  availability_id = Availability.create(
                                        listing_id: listing_id,
                                        building_id: building_id,
                                        start_date: start_date,
                                        end_date: end_date
                                        ).id
  Transaction.create(
                     spot_id: spot_id,
                     buyer_id: buyer_id,
                     seller_id: seller_id,
                     availability_id: availability_id,
                     start_date: start_date,
                     end_date: end_date,
                     price: price,
                     cancelled: false
                     ).id
end

timber_ridge = add_building('Timber Ridge', '2980 Euclid Ave., Boulder, CO 80303')
spire = add_building('The Spire', 'Somewhere around 15th and Champa')

# Add the seed data
bob = add_user('Bob', false, timber_ridge)
joe = add_user('Joe', false, timber_ridge)
alice = add_user('Alice', false, spire)
eve = add_user('Eve', false, spire)
jack = add_user('Jack', true, timber_ridge, true, true)
justin = add_user('Justin', true, spire)


spot1 = add_spot(timber_ridge, 1, 1, bob)
spot2 = add_spot(timber_ridge, 1, 2, joe)
spot3 = add_spot(spire, 9, 37, alice)
spot4 = add_spot(spire, 7, 12, eve)

add_transaction(timber_ridge, spot2, bob, alice, Date.today, Date.today + 1, 10)
