# frozen_string_literal: true

class IkedaNote::TeamsController < IkedaNote::ApplicationController
  before_action :set_team, only: %i[edit update destroy]

  def index
    @teams = Team.where(user: current_user)
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.build(team_params)
    if @team.valid?
      @team.save!
      redirect_to({ action: :index }, notice: '作成しました')
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to({ action: :index }, notice: '更新しました')
    else
      render action: :edit
    end
  end

  def destroy
    if @team.destroy
      redirect_to({ action: :index }, notice: '削除しました')
    else
      redirect_to({ action: :index }, alert: @team.errors.full_messages.to_sentence)
    end
  end

  private

  def team_params
    params
      .require(:team)
      .permit(:name, :color_code)
  end

  def set_team
    # TODO: notFoundのハンドリング
    @team = current_user.teams.find(params[:id])
  end
end
