class Bank < ApplicationRecord
  validates :name, length: { maximum: 50 },  presence: true, uniqueness: true
end
