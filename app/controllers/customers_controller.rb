class CustomersController < ApplicationController
  def register
    @provinces = Province.order(:code)
  end

  def create
    if params['name']  == '' || params['email'] == '' || params['address'] == '' || params['postal_code'] == ''
      redirect_to :controller => 'customers', :action => 'register'
    elsif params['password'] != params['confirm']
      redirect_to :controller => 'customers', :action => 'register'
    else
      Customer.create(name:         params['name'],
                      email:        params['email'],
                      password:     params['password'],
                      address:      params['address'],
                      city:         params['city'],
                      province_id:  params['province'],
                      postal_code:  params['postal_code'])

      redirect_to :controller => 'products', :action => 'index'
    end
  end
end
