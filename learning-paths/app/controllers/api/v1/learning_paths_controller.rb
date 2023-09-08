class Api::V1::LearningPathsController < ApplicationController
  before_action :set_learning_path, only: %i[show update destroy]
  def index
    @learning_paths = LearningPath.all
    render json: @learning_paths, status: :ok
  end

  def show
    render json: @learning_path, status: :ok
  end

  def create
    @learning_path = LearningPath.create(learning_path_params)
    render json: @learning_path, status: :created
  end

  def update
    @learning_path.update(learning_path_params)
    render json: @learning_path, status: :ok
  end

  def destroy
      @learning_path.destroy
      render json: { message: 'Learning path successfully deleted' }, status: :ok
  end

  private

  def learning_path_params
    params.require(:learning_path).permit(:name, :description)
  end

  def set_learning_path
    @learning_path = LearningPath.find(params[:id])
  end
end
