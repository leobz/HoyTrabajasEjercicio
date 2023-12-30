class Bank < ApplicationRecord
  validates :name, length: { maximum: 50 },  presence: true, uniqueness: true

  self.primary_key = :name
end
