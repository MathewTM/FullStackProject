class ProductsController < ApplicationController
  def index
    if params[:keyword] != nil then
      @products = Product.where("name LIKE :keyword", {:keyword => "%" + params[:keyword] + "%"})
    else
      @products = Product.all
    end
  end
end
