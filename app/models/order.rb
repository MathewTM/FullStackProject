class Order < ApplicationRecord
  belongs_to :customer
  has_many   :line_item
end
