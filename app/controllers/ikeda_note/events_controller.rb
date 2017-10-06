class IkedaNote::EventsController < IkedaNote::ApplicationController
  before_action :set_event, only: %i[edit update destroy]
  before_action :set_people, only: %i[new create edit update]

  def index
    @events = Event.includes(people: :team)
      .where(user: current_user)
      .order(:occurrence_year)
  end

  def new
    @event = Event.new
    @event.event_people.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.valid?
      @event.save!
      redirect_to({ action: :index }, notice: '作成しました')
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to({ action: :index }, notice: '更新しました')
    else
      render action: :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to({ action: :index }, notice: '削除しました')
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
