## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class UsersController < ApplicationController
    include BCrypt

    # Before performing the called for action, check if the user is logged in
    before_action :logged_in_user

    def show
        @user = @current_user
        # Check if the user has 2FA enabled
        # For non 2FA enabled accounts, value must be = "0"
        if (Password.valid_hash?(@user.securelogin))
          @securePass = "T2984TYVN92845YTVN928"
        else
          @securePass = "0"
        end
    end

    def secure
        @user = @current_user

        # Only if user has sent the seclogin field
        if(params[:seclogin])
            secpw = params[:seclogin]
            
            # and only if the seclogin field is not blank
            if(secpw.blank?)
                @secloginerror = "Secondary Password Must not be Empty"
                @securePass = "0"
                render("users/show")
                return
            end
            
            # If seclogin = "0" -> user wants to disable 2FA
            if(secpw == "0")
                password = "0"
            else
                password = Password.create(secpw)
            end
            
            @user.securelogin = password
            @user.save
            redirect_to("/profile")
        else
            redirect_to("/profile")
        end
    end

    #Regex for checking if a value is blank
    BLANK_RE = /\A[[:space:]]*\z/
    private
    def blank?
      # The regexp that matches blank strings is expensive. For the case of empty
      # strings we can speed up this method (~3.5x) with an empty? call. The
      # penalty for the rest of strings is marginal.
      empty? || BLANK_RE.match?(self)
    end

  end
