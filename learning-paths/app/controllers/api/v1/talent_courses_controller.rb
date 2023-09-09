class Api::V1::TalentCoursesController < ApplicationController
    before_action :set_talent_course, only: %i[update]

    # Enroll into course on a learning path
    def create
      @talent_course = TalentCourse.create(talent_course_params)
      render json: @talent_course, status: :created
    end
  
    # Move to next course in learing path/complete learning path.
    def update
      @talent_course.update(talent_course_params)
      @talent_course.complete_course()
      render json: @talent_course, status: :ok
    end
  
    private
  
    def talent_course_params
      params.require(:talent_course).permit(:talent_id, :course_id, :completed)
    end

    def set_talent_course
        @talent_course = TalentCourse.find(params[:id])
    end

  end