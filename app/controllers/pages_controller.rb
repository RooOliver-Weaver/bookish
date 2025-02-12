class PagesController < ApplicationController
  def home
    @books = Book.all.sample(4)
  end
end
