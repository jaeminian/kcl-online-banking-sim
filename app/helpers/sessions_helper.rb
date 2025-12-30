## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

module SessionsHelper

  # Set the session variable for this user, equivalent to their ID
  def log_in(user)
    session[:user_id] = user.id
  end

  # Set a secondary Session variable for users logging in using 2FA.
  # This will be used to fetch the users record when secondary password is going to be validated
  def partial_login(user)
    session[:user_id_partial] = user.id
  end
  
  # Once secondary login is successful the partial login is deleted
  def partial_login_delete
    session.delete(:user_id_partial)
    @current_user = nil
  end

  # return the currently logged in user in case there is any, else nil
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Return boolean for if any user is logged
  def logged_in?
    !current_user.nil?
  end

  # Destroys session variable 
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Checks if the current user matches the paramter user
  def current_user?(user)
    user == current_user
  end

  # The end user is sent to a stored location, if there is none then the default is used
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # In case the user is to be redirected, their location is stored in the header.
  # To send the user back to this page once the neccessary action is performed
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # Check if the curent user is an administrator
  def is_check_admin?
    if session[:user_id]
      to_ret = User.find_by(id: session[:user_id], :admin => true)
      !to_ret.nil?
    else
      false
    end
  end

  # Check if the user param passed is an admin
  def is_admin? user
    if user.admin
      true
    else
      false
    end
  end

  # Check if user has enavled 2FA
  def secure_enabled? user
    user.securelogin != "0"
  end
  
end