class Order < ApplicationRecord
  validation :name, presence: true, length: { maximum: 40 }
  validation :email, presence: true, length: { maximum: 100 }
  validation :telephone, presence: true, length: { maximum: 11 }, numericality: { only_integer: true }
  validation :delivery_address, presence: true, length: { maximum: 100 }
end
