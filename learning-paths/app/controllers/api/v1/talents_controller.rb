class Api::V1::TalentsController < ApplicationController
  before_action :set_talent, only: %i[show update destroy]
  def index
    @talents = Talent.all
    render json: @talents, status: :ok
  end

  def show
    render json: @talent, status: :ok
  end

  def create
    @talent = Talent.create(talent_params)
    render json: @talent, status: :created
  end

  def update
    @talent.update(talent_params)
    render json: @talent, status: :ok
  end

  def destroy
    @talent.destroy
    render json: { message: 'Talent successfully deleted' }, status: :ok
  end

  private

  def talent_params
    params.require(:talent).permit(:username, :email, :author_id)
  end

  def set_talent
    @talent = Talent.find(params[:id])
  end
end
