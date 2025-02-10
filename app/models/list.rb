class List < ApplicationRecord
  belongs_to :user
  has_many :book_lists
  has_many :books, through: :book_lists

  validates :name, presence: true
end
