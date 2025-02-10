class ListsController < ApplicationController
  def index
    @lists = current_user.lists
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      redirect_to user_list_path(current_user, @list), notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
