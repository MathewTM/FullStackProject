class ChargesController < ApplicationController
  def new
    if session[:user].nil?
      session[:redirect] = { controller: 'charges', action: 'new'}
      redirect_to :controller => 'customers', :action => 'login'
    else
      customer = Customer.find_by(id: session[:user]['id'])
      @subtotal = 0

      @cart = fill_cart
      @pst = @subtotal * (customer.province.pst.to_f / 100)
      @gst = @subtotal * 0.05
      session[:total] = @subtotal + @pst + @gst
      @description = 'Give me Money!'
    end
  end

  def create
    session.delete(:cart)

    stripeCustomer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => stripeCustomer.id,
      :amount      => session[:total].to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'cad'
    )

    customer = Customer.find_by(id: session[:user]['id'])
    Order.create(customer_id:   customer.id,
                 amount:        charge.amount / 100,
                 paid:          true,
                 stripe_email:  params[:stripeEmail],
                 stripe_token:  params[:stripeToken])

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
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
    @subtotal += search.price * 100 * product[:occurances]
  end
  cart
end
