## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class UserAdminsController < ApplicationController
  # Before performing the called for action, check if the user is an Admin
  before_action :logged_in_user_admin

  def index
    # Get users in ascending order by first name
    @users = User.order('fname ASC')
  end

  def show
    # Get users with id => :id
    @user = User.find(params[:id])
  end

  def new
    @user = User.new()
  end

  def create
    # Create new user with selectively defined params
    @user = User.new(user_params_new)

    # User saved with a context for selective validation only 
    if @user.save(context: :create)
      redirect_to (user_admin_path(@user))
    else
      render('new')
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    # Contecxt used for selective data validation only
    if @user.save(context: :partialsave)
      redirect_to (user_admin_path(@user))
    else
      render('edit')
    end
  end

  def password_change
    # Loads the user to change the password for
    @user = User.find(params[:id])
  end

  def password_change_action
    @user = User.find(params[:id])
    @user.update(user_params_pw)

    # Context for selective user password change
    if @user.save(context: :pwchange)
      redirect_to (user_admin_path(@user))
    else
      render('password_change')
    end
  end



  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    # User is only destroyed if they dont have any accounts associated with them
    @user.destroy unless Account.where(:user_id => @user.id).length > 0
    redirect_to(user_admins_path)
  end

  private
  def user_params_new
    # Params required for a new user
    params.require(:user).permit(:fname, :lname, :email,:admin, :username, :password, :password_confirmation)
  end

  private
  def user_params
    # Params required for updating a users details
    params.require(:user).permit(:fname, :lname, :email,:admin, :username)
  end

  private
  def user_params_pw
    # Params required for changing a users password
    params.require(:user).permit(:password, :password_confirmation)
  end

end
