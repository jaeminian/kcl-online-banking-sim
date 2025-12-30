## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class TransfersController < ApplicationController
  before_action :logged_in_user

  def new
    # Check if the account with this ID exists, else render error page
    @account = Account.find_by(:id=> params[:accid], :user_id => @current_user.id)
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
      return
    end
    # Make a new Transaction
    @transfer = Transaction.new
    # Default amount set to 0.00
    @transfer.amount = 0.00
    # Find the currency of this account
    @currency = Currency.find(@account.curr_id)
  end

end