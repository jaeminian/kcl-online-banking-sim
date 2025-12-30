## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class ApplicationController < ActionController::Base
    include SessionsHelper

    private
    def logged_in_user
        # Check if any type of user is logged in else redirect them to the login page
        unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
        end
    end

    private
    def logged_in_user_admin
        # The logged in user must be an Administrator else send them to the accounts page
        unless (is_check_admin?)
        store_location
        flash[:danger] = "Please log in as an Admin to Continue"
        redirect_to accounts_path
        end
    end
end
