class HomePageViewModel
  def featured_events
    Event.last(3).reverse
  end

  def closest_events
    Event.order(:date).last(3).reverse
  end
end