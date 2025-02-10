class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :book_lists
  has_many :lists, through: :book_lists

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
end
