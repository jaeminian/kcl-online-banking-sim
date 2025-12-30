## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class AccountAdminsController < ApplicationController
  # Check if the User has Logged in as an Administrator
  before_action :logged_in_user_admin


  def index
    # Sort accounts by ascending order of ID
    @accounts = Account.order('id ASC')
  end

  def show
    # Check if account this ID Exists else render error page 
    @account = Account.find_by(:id=> params[:id])
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
      return
    end
    # If account eith id exists then load all transactions
    @transactions = Transaction.where(account_id: @account.id).order("created_at DESC")

    # If not transactions, throw warning message
    if (@transactions.empty?)
      flash.now[:danger] = 'No transactions'
    end

    curr = Currency.find(@account.curr_id)
    total = 0
    # Calculate current balance for the account
    @transactions.each do |t|
      total += t.amount
    end

    # Credits are stored as negative values and debits as positives hence we multiply by -1
    result = -1 * total
    @balance = curr.shortname + " " + result.to_s
  end

  def new
    @account = Account.new(:curr_id => 1, :user_id => 1)
  end

  def create
    # Limit the params sent by the accounts_params method
    @account = Account.new(account_params)

    if @account.save
      redirect_to (account_admins_path)
    else
      # In case there were errors in saving
      render('new')
    end

  end

  def edit
    @account = Account.find_by(:id=> params[:id])
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to (account_admin_path(@account))
    else
      render('edit')
    end
  end

  def delete
    @account = Account.find_by(:id=> params[:id])
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
    end
  end

  def destroy
    @account = Account.find(params[:id])

    @transaction = Transaction.where(:account_id => @account.id)
    @transaction.each do |trans|
      trans.destroy
    end

    @account.destroy
    redirect_to(account_admins_path)
  end

  private
    def account_params
      params.require(:account).permit(:accname, :accnumber, :sortcode, :curr_id, :user_id)
    end
end
