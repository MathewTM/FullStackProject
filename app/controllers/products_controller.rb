class ProductsController < ApplicationController
  def index
    unless session[:cart] then session[:cart] = {} end

    if !params[:keyword].nil?
      kw = '%' + params[:keyword] + '%'
      @products = Product.where('name LIKE :kw OR description LIKE :kw', :kw => kw)
    else
      @products = Product.all
    end
  end

  def view
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
    if !session[:cart].include? params[:id]
      session[:cart] = session[:cart].merge!(params[:id] => { 'occurances' => 1 })
    else
      session[:cart][params[:id]]['occurances'] += 1
    end

    redirect_to :controller => 'products', :action => 'index'
  end

  def cart
    session[:subtotal] = 0
    @cart = fill_cart
  end

  def checkout
    @provinces = Province.order(:code)
  end

  def payment
    @name = params['name']
    @address = params['address']
    @city = params['city']
    @province = params['province']
    @postal_code = params['postal_code']

    if @name == '' || @email == '' || @address == '' || @city == '' || @postal_code == ''
      redirect_to :controller => 'products', :action => 'checkout'
    end

    session[:subtotal] = 0

    province = Province.find_by(code: @province)
    @cart = fill_cart
    @pst = session[:subtotal] * province.pst.to_f / 100
    @gst = session[:subtotal] * 0.05
    @total = session[:subtotal] + @pst + @gst
  end

  private
  def fill_cart
    cart = []

    session[:cart].each do |item|
      search = Product.find_by(id: item)
      product = {}
      product[:id] = search.id
      product[:name] = search.name
      product[:price] = search.price
      product[:occurances] = item[1]['occurances']
      cart << product
      session[:subtotal] += search.price * product[:occurances]
    end
    cart
  end
end
