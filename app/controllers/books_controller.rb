class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @books = Book.all
    @book = Book.new
    @authors = Author.all
    @genres = Genre.all
  end

  def show
    @book = Book.find(params[:id])
    if current_user.nil?
      @lists = []
    else
      @lists = current_user.lists
    end
  end

  def new
    @book = Book.new
    @authors = Author.all
    @genres = Genre.all
  end

  def create
    author_id = params[:book][:author_id].to_i
    genre_id = params[:book][:genre_id].to_i

    author = Author.find_by(id: author_id)
    genre = Genre.find_by(id: genre_id)

    @book = Book.new(book_params.merge(author: author, genre: genre))

    open_library_service = OpenLibraryService.new
    book_info = open_library_service.fetch_book_details(@book.title)

    @book.isbn = book_info[:isbn] if book_info[:isbn].present?
    @book.cover_url = book_info[:cover_url] if book_info[:cover_url].present?

    if author.nil? || genre.nil?
      flash[:alert] = "Author or Genre not found"
      @book = Book.new(book_params)
      @authors = Author.all
      @genres = Genre.all
      render "new" and return
    end

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      @authors = Author.all
      @genres = Genre.all
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
    @authors = Author.all
    @genres = Genre.all
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      @authors = Author.all
      @genres = Genre.all
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path, notice: "Book was successfully deleted."
  end

  private

  def book_params
    params.require(:book).permit(:title, :synopsis, :isbn, :cover_url)
  end
end
