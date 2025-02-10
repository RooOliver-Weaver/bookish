require "httparty"

class OpenLibraryService
  def self.fetch_book_details(title)
    encoded_title = URI.encode_www_form_component(title)
    url = "https://openlibrary.org/search.json?title=#{encoded_title}&limit=1"

    response = HTTParty.get(url)
    if response.success? && response["docs"].present?
      book_data = response["docs"].first
      isbn = book_data["isbn"]&.first
      cover_id = book_data["cover_i"]
      cover_url = cover_id ? "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg" : nil

      { isbn: isbn, cover_url: cover_url }
    else
      { isbn: "N/A", cover_url: nil }
    end
  end
  def fetch_book_details(title)
    encoded_title = URI.encode_www_form_component(title)
    url = "https://openlibrary.org/search.json?title=#{encoded_title}&limit=1"

    response = HTTParty.get(url)
    if response.success? && response["docs"].present?
      book_data = response["docs"].first
      isbn = book_data["isbn"]&.first
      cover_id = book_data["cover_i"]
      cover_url = cover_id ? "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg" : nil

      { isbn: isbn, cover_url: cover_url }
    else
      { isbn: "N/A", cover_url: nil }
    end
  end
end
