# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
require "httparty"
require_relative "../app/services/open_library_service"

# Destroy existing records
BookList.destroy_all
List.destroy_all
User.destroy_all
Book.destroy_all
Author.destroy_all
Genre.destroy_all

# Create a test user
user = User.create!(email: "test@example.com", password: "password")

# Create genres
fiction = Genre.create!(name: "Fiction")
fantasy = Genre.create!(name: "Fantasy")
mystery = Genre.create!(name: "Mystery")
science_fiction = Genre.create!(name: "Science Fiction")

# Create authors
tolkien = Author.create!(name: "J.R.R. Tolkien")
rowling = Author.create!(name: "J.K. Rowling")
agatha = Author.create!(name: "Agatha Christie")
asimov = Author.create!(name: "Isaac Asimov")

# List of books with authors and genres
books = [
  { title: "The Hobbit", author: tolkien, genre: fantasy, synopsis: "A fantasy novel about the adventures of Bilbo Baggins." },
  { title: "Harry Potter and the Sorcerer's Stone", author: rowling, genre: fantasy, synopsis: "A young wizard embarks on his first year at Hogwarts." },
  { title: "Murder on the Orient Express", author: agatha, genre: mystery, synopsis: "Detective Hercule Poirot solves a murder aboard the famous train." },
  { title: "I, Robot", author: asimov, genre: science_fiction, synopsis: "A collection of short stories about robots and their interactions with humans." }
]

# Create books with API details
books.each do |book_data|
  details = OpenLibraryService.fetch_book_details(book_data[:title])

  Book.create!(
    title: book_data[:title],
    author: book_data[:author],
    genre: book_data[:genre],
    synopsis: book_data[:synopsis],
    isbn: details[:isbn] || "N/A",
    cover_url: details[:cover_url] || "https://via.placeholder.com/150x200?text=No+Cover"
  )
end

puts "✅ Seeded #{books.size} books with cover images!"
