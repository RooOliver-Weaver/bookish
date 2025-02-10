class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    @author = Author.new
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.find_or_create_by(name: params[:author][:name])

    respond_to do |format|
      format.json { render json: @author}
    end
  end
end
