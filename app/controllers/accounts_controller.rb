## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class AccountsController < ApplicationController
  # Check if user is logged in  
  before_action :logged_in_user
  def index
    # If user is an admin, send them to the consoles page
    @user = @current_user
    if is_admin? @user
      redirect_to(consoles_path)
      return
    end
    
    @accounts = Account.where(:user_id => @user.id).order('accname ASC')
  end

  def edit
    @account = Account.find_by(:id=> params[:id], :user_id => @current_user.id)
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
    end
  end

  def update
    @account = Account.find_by(:id=> params[:id], :user_id => @current_user.id)
    if(@account.nil?)
      @msg = "An account with this ID was unfortunately not found :("
      render("error_pages/index")
    else
      if @account.update(account_params)
        redirect_to "/transactions/#{@account.id}"
      else
        render('edit')
      end
    end
  end

  private
  def account_params
    params.require(:account).permit(:accname, :curr_id)
  end

end
