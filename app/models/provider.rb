class Provider < ApplicationRecord
  validates :nit, format: { with: /[0-9]{9}-[0-9]?/}
  validates :name, presence: true
  validates :bank_id, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, length: { maximum: 10 }
  validates :account_number, length: { maximum: 15 }
end
