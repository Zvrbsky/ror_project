# frozen_string_literal: true

class HomePageViewModel
  def featured_events
    Event.last(3).reverse
  end

  def closest_events
    Event.order(:date).first(3).reverse
  end
end
