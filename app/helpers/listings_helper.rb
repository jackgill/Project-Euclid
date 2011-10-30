module ListingsHelper
  def format_lister(lister)
    lister.first_name + ' ' + lister.last_name
  end

  def format_spot(spot)
    spot.building.name + ' ' + spot.number.to_s
  end
end
