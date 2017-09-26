class IkedaNote::EventsController < IkedaNote::ApplicationController
  def index
    @events = current_user.events
  end
end
