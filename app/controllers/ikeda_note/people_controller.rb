class IkedaNote::PeopleController < IkedaNote::ApplicationController
  before_action :set_person, only: %i[edit update destroy]
  before_action :set_teams, only: %i[new create edit update]

  def index
    @people = Person.includes(:team)
      .where(user: current_user)
  end

  def new
    @person = Person.new
  end

  def create
    @person = current_user.people.build(person_params)
    if @person.valid?
      @person.save!
      redirect_to({ action: :index }, notice: '作成しました')
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to({ action: :index }, notice: '更新しました')
    else
      render action: :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to({ action: :index }, notice: '削除しました')
  end

  private

  def person_params
    params
      .require(:person)
      .permit(:name, :team_id)
  end

  def set_person
    # TODO: notFoundのハンドリング
    @person = current_user.people.find(params[:id])
  end

  def set_teams
    @teams = current_user.teams
  end
end
