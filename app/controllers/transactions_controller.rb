## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class TransactionsController < ApplicationController
  before_action :logged_in_user
  # User can only see transcations linked to their user_id
  def index
    #find specified account for current user
    @account = Account.find_by(:id=> params[:accid], :user_id => @current_user.id)
    # If User tried to access another User's account, show the error page:"An account with this ID was unfortunately not found :("
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
    else
      @transactions = Transaction.where(account_id: @account.id).order("created_at DESC")
      if (@transactions.empty?)
        flash.now[:danger] = 'No transactions'
      end
      @currency = Currency.find(@account.curr_id)
      total = 0
      # Calculate current balance for the account
      @transactions.each do |t|
        total += t.amount
      end
      # Credits(money granted to account) are stored as negative values
      # and debits(money taken from account) as positive numbers hence we multiply by -1 to get the balance
      result = -1 * total
      @balance = @currency.shortname + " " + result.to_s
    end
  end

  def create
    # User can only see transcations linked to their user_id
    @account = Account.find_by(:id=> params[:accid], :user_id => @current_user.id)
    @currency = Currency.find(@account.curr_id)
    # If User tried to access another User's account, show the error page:"An account with this ID was unfortunately not found :("
    if(@account.nil?)
      @msg = cc
      render("error_pages/index")
    else
      @transfer = Transaction.new(transfer_params)
      @transfer.account = @account
      if params[:transaction][:amount].to_i < 0.01
        flash.now[:danger] = "Invalid Amount Selected"
        
        render("transfers/new")
        return
      end
      # :type refers to selected money transfer type (0 - Debit, 1 - Credit)
      # Debits are stored as positive numbers and credits as negative
      if params[:type].to_i == 0
        @transfer.amount *= 1
      elsif params[:type].to_i == 1
        @transfer.amount *= -1
      else  # countermeasure if user alters html through inspect elements
        flash.now[:danger] = "Invalid Type Selected"
        render("transfers/new")
        return
      end

      if @transfer.save
        redirect_to("/transactions/#{@account.id}")
      else
        render("transfers/new")
      end
    end
  end

  public
    def transfer_params
      params.require(:transaction).permit(:amount, :receiver, :type)
    end

end
