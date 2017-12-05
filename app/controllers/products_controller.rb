class ProductsController < ApplicationController
  def index
    @catagories = Catagory.all

    keyword = params[:keyword]
    search_by = params[:search_by]

    if keyword == '' then keyword = nil end
    if search_by == '' then search_by = nil end

    if !keyword.nil? and !search_by.nil? then
      @products = Product.where("(name LIKE :keyword OR description LIKE :keyword) AND catagory_id=:search_by", :keyword => '%' + keyword + '%', :search_by => search_by)
    elsif !keyword.nil? && search_by.nil? then
      @products = Product.where('name LIKE :keyword OR description LIKE :keyword', :keyword => '%' + keyword + '%')
    elsif keyword.nil? && !search_by.nil? then
      @products = Product.where('catagory_id=:search_by', :search_by => search_by)
    else
      @products = Product.all
    end
  end

  def view
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
    unless session[:cart] then session[:cart] = {} end

    if !session[:cart].include? params[:id]
      session[:cart] = session[:cart].merge!(params[:id] => { 'occurances' => 1 })
    else
      session[:cart][params[:id]]['occurances'] += 1
    end

    redirect_to :controller => 'products', :action => 'index'
  end

  def cart
    @subtotal = 0
    @cart = []

    session[:cart].each do |item|
      search = Product.find_by(id: item)
      product = { id: search.id, name: search.name, price: search.price, occurances: item[1]['occurances'] }
      @cart << product
      @subtotal += search.price * 100 * product[:occurances]
    end
  end

  def add_one
    session[:cart][params[:id]]['occurances'] += 1
    redirect_to :controller => 'products', :action => 'cart'
  end

  def remove_one
    session[:cart][params[:id]]['occurances'] -= 1
    if session[:cart][params[:id]]['occurances'] == 0 then session[:cart].delete(params[:id]) end
    redirect_to :controller => 'products', :action => 'cart'
  end

  def remove_all
    session[:cart].delete(params[:id])
    redirect_to :controller => 'products', :action => 'cart'
  end
end
