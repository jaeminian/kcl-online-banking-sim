## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class CurrencyAdminsController < ApplicationController
  before_action :logged_in_user_admin
  def index
    @currencies = Currency.order('bigname ASC')
  end

  def show
    @currency = Currency.find(params[:id])
  end

  def new
    @currency = Currency.new()
  end

  def create
    # Make a new currency with currency_params
    @currency = Currency.new(currency_params)
    if @currency.save
      redirect_to (currency_admin_path(@currency))
    else
      render('new')
    end
  end

  def edit
    @currency = Currency.find(params[:id])
  end

  def update
    # Update values of currency with currency_params
    @currency = Currency.find(params[:id])
    if @currency.update(currency_params)
      redirect_to (currency_admin_path(@currency))
    else
      render('edit')
    end
  end

  def delete
    @currency = Currency.find(params[:id])
  end

  def destroy
    @currency = Currency.find(params[:id])
    # The currency cannot be deleted if there is an account using it
    @currency.destroy unless Account.where(:curr_id => @currency.id).length > 0
    redirect_to(currency_admins_path)
  end

  private
    def currency_params
      params.require(:currency).permit(:bigname, :shortname)
    end
end