class Api::V1::TalentLearningPathsController < ApplicationController
    before_action :set_talent_learning_path, only: %i[update]
    def create
      @talent_learning_path = TalentLearningPath.create(talent_learning_path_params)
      render json: @talent_learning_path, status: :created
    end
  
    def update
      @talent_learning_path.update(talent_learning_path_params)
      render json: @talent_learning_path, status: :ok
    end
  
    private
  
    def talent_learning_path_params
      params.require(:talent_learning_path).permit(:talent_id, :learning_path_id, :completed)
    end

    def set_talent_learning_path
      @talent_learning_path = TalentLearningPath.find(params[:id])
    end

  end