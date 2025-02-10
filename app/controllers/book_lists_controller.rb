class BookListsController < ApplicationController
  def create
    Rails.logger.debug "Params: #{params.inspect}"
    @book_list = BookList.new(book_list_params)
    if @book_list.save
      redirect_to user_list_url(current_user, @book_list.list), notice: "Book added to list successfully."
    else
      Rails.logger.debug "Errors: #{@book_list.errors.full_messages}"
      redirect_to books_url, alert: "Failed to add book to list: #{@book_list.errors.full_messages.join(', ')}"
    end
  end

  private

  def book_list_params
    params.require(:book_list).permit(:book_id, :list_id)
  end
end
