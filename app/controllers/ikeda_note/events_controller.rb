class IkedaNote::EventsController < IkedaNote::ApplicationController
  before_action :set_event, only: %i[edit update destroy]
  before_action :set_people, only: %i[new edit]

  def index
    @events = Event.includes(people: :team)
      .where(user: current_user)
  end

  def new
    @event = Event.new
    @event.event_people.build
  end

  def create
    event = current_user.events.build(event_params)
    return unless event.valid?

    # TODO: バリデーション
    event.save
    redirect_to action: :index
  end

  def edit
    @people = current_user.people
  end

  def update
    # TODO: バリデーション
    @event.update!(event_params)
    redirect_to action: :index
  end

  def destroy
    @event.destroy
    redirect_to action: :index
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:name, :occurrence_year, event_people_attributes: [:id, :person_id, :_destroy])
  end

  def set_event
    # TODO: notFoundのハンドリング
    @event = current_user.events.find(params[:id])
  end

  def set_people
    @people = current_user.people
  end
end
