## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class SessionsController < ApplicationController
  include BCrypt

  def new
    # If user is already logged in, redirect to the accounts page
    if (logged_in?)
      redirect_back_or accounts_path
    end
  end

  def create
    # Check login credentials are correct
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])

      if (secure_enabled? user)
        # Send user to secure login form (second password authentication)
        partial_login user
        render('secure')
        return
      else
        if is_admin? user
          # If user is an admin, redirect to the admin page
          flash[:success] = "Welcome to the Admin Panel!"
          log_in user
          redirect_back_or '/admin'
        else
          # If user is not an admin, redirect to the accounts page
          flash[:success] = "Welcome to the app Personal Banking User!"
          log_in user
          redirect_back_or accounts_path
        end
      end

    else
      # If login credentials are incorrect, send an error message and re-render the form
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  # Redirect to first login phase if GET is called for the securelogin page
  def newsecure
    redirect_to login_path
  end

  def secure
    # Redirect to the first login phase if the database user is suddenly non-existent (e.g. deleted)
    if !(session[:user_id_partial])
      flash.now[:danger] = 'Invalid User Credentials'
      render 'new'
      return
    end

    # Re-render the secure login form if the secure password is incorrect
    if !(params[:secure])
      flash.now[:danger] = 'Invalid Secondary Password'
      render('secure')
      return
    end

    seclogin = params[:secure]
    user = User.find(session[:user_id_partial])
    # Re-render first login phase if the database user does not require a secure password
    if !(secure_enabled? user)
      flash.now[:danger] = '2-Factor Authentication Not Enabled'
      render 'new'
      return
    end

    user.reload
    # Decrypt the encrypted stored password
    secpass = Password.new(user.securelogin)

    if !(secpass == seclogin)
      flash.now[:danger] = 'Invalid Password'
      render('secure')
      return
    end

    # Clear up values used for the secure login process
    partial_login_delete

    if is_admin? user
      flash[:success] = "Welcome to the Admin Panel!"
      log_in user
      redirect_back_or '/admin'
    else
      flash[:success] = "Welcome to the app Personal Banking User!"
      log_in user
      redirect_back_or accounts_path
    end

  end

  def destroy
    log_out
    redirect_to root_url
  end
end
