class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]
  def index
    @courses = Course.all
    render json: @courses, status: :ok
  end

  def show
    render json: @course, status: :ok
  end

  def create
    @course = Course.create(course_params)
    render json: @course, status: :created
  end

  def update
    @course.update(course_params)
    render json: @course, status: :ok
  end

  def destroy
    @course.destroy
    render json: { message: 'Course successfully deleted' }, status: :ok
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :order, :author_id, :learning_path_id)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
