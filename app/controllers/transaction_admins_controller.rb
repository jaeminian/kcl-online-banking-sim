## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class TransactionAdminsController < ApplicationController
  include TransactionAdminsHelper
  #Check if current user is admin
  before_action :logged_in_user_admin

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to(transaction_admins_path())
    else
      render('new')
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to(transaction_admin_path(@transaction))
    else
      render('edit')
    end
  end

  def delete
    @transaction = Transaction.find(params[:id])
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to(transaction_admins_path)
  end

  # Method Generates Random 10 Transactions + 1 Salary transaction for the selected user
  def random
    # The Acccounts of the current user is fetched
    account = Account.find(params[:accid])
    # The Current Unix Time is fetched and stored as integer
    now_unix = Time.now.to_i

    # gets a list of receivers according which currency is selected
    get_receivers(account.curr_id)

    #Create an initial deposit backdated to 10 days before
    Transaction.create(
      account: account,
      receiver: "Salary Transfer",
      amount: -5000,
      created_at: Time.at(now_unix - 864000)
    )

    # For each of the local receivers, insert the transaction with random amounts and any random date between 14 days before and a few hours before
    @receivers.each do |r|
      Transaction.create(
          account: account,
          receiver: r,
          amount: rand(10..500),
          created_at: Time.at(now_unix - rand(10000..854000))
      )
    end
    # Send back to Accounts Admins path once transactions are generated
    flash[:success] = "Random Transactions Successfully Added"
    redirect_to(account_admins_path)
    return
  end


  private
  def transaction_params
    params.require(:transaction).permit(:receiver, :amount, :account_id)
  end
end
