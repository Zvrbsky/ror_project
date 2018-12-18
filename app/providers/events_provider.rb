class EventsProvider
  attr_reader :results

  def initialize(search, cat)
    @results = Event.all
    @results = filter_events(cat)
    @results = search_events(search)
    # binding.pry
  end

  def search_events(search)
    @results = if search.nil?
                 @results
               elsif search == ''
                 @results
               else
                 @results.where("title LIKE '%#{search}%'")
               end
  end

  def filter_events(cat)
    @results = if cat.nil?
                 @results
               elsif cat == ''
                 @results
               else
                 @results.where(category: cat)
               end
  end
end
