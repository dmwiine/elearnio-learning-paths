class Api::V1::AuthorsController < ApplicationController
  before_action :set_author, only: %i[show update destroy]
  def index
    @authors = Author.all
    render json: @authors, status: :ok
  end

  def show
    render json: @author, status: :ok
  end

  def create
    @author = Author.create(author_params)
    render json: @author, status: :created
  end

  def update
    @author.update(author_params)
    render json: @author, status: :ok
  end

  def destroy
      @author.update_courses(params[:author][:author_id])
      @author.destroy
      render json: { message: 'Author successfully deleted' }
  end

  private

  def author_params
    params.require(:author).permit(:firstname, :lastname, :bio, :author_id)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
