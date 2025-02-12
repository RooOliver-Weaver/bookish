class GenresController < ApplicationController

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.find_or_create_by(name: params[:genre][:name])

    respond_to do |format|
      format.json { render json: @genre }
    end
  end
end
