class Customer < ApplicationRecord
  belongs_to :province
  has_many   :order
end
