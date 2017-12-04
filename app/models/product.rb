class Product < ApplicationRecord
  has_one :line_item
  belongs_to :catagory
end
