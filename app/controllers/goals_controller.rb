class GoalsController < ApplicationController

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find_by_id(params[:id])
    render :show
  end

  def index
    @goals = Goal.all
    render :index
  end

  def update
    @goal = Goal.find_by_id(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def edit
    @goal = Goal.find_by_id(params[:id])
    render :edit
  end

  def destroy
    @goal = Goal.find_by_id(params[:id])
    @goal.destroy
    redirect_to user_url(current_user.id)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :visible)
  end
end
