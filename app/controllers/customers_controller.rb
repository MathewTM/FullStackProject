class CustomersController < ApplicationController
  def register
    @provinces = Province.order(:code)
  end

  def create
    if params['email']  == '' || params['password'] == '' || params['confirm'] == '' || params['name'] == '' || params['address'] == '' || params['city'] == '' || params['postal_code'] == ''
      redirect_to :controller => 'customers', :action => 'register'
    elsif params['password'] != params['confirm']
      redirect_to :controller => 'customers', :action => 'register'
    else
      customer = Customer.create(email:        params['email'],
                                 password:     params['password'],
                                 name:         params['name'],
                                 address:      params['address'],
                                 city:         params['city'],
                                 province_id:  params['province'],
                                 postal_code:  params['postal_code'])

      session[:user] = { id: customer.id, name: customer.name }
      redirect_to :controller => 'products', :action => 'index'
    end
  end

  def logout
    session.delete(:user)
    redirect_to :controller => 'products', :action => 'index'
  end

  def login
  end

  def confirm
    if params['email'] == '' || params['password'] == ''
      flash[:notice] = 'Must enter an email and password'
      redirect_to :controller => 'customers', :action => 'login'
    else
      customer = Customer.find_by(email: params['email'])
      if customer.nil? || params['password'] != customer.password
        flash[:notice] = 'Incorrect email or password'
        redirect_to :controller => 'customers', :action => 'login'
      else
        session[:user] = { id: customer.id, name: customer.name }
        if session[:redirect]
          redirect_to :controller => session[:redirect]['controller'], :action => session[:redirect]['action']
          session.delete(:redirect)
        else
          redirect_to :controller => 'products', :action => 'index'
        end
      end
    end
  end
end
