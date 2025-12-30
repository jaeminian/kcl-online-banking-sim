## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class UserAdminsControllerTest < ActionDispatch::IntegrationTest

  # Access Tests for Index, New, Show, Edit, Delete Views
  test "get index should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)
    get user_admins_path
    assert_response :success
  end

  test "get index should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get user_admins_path
    assert_redirected_to accounts_path
  end

  test "get index should redirect to login when not logged in" do  
    get user_admins_path
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get new should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)    
    get new_user_admin_path
    assert_response :success
  end

  test "get new should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get new_user_admin_path
    assert_redirected_to accounts_path
  end

  test "get new should redirect to login when not logged in" do  
    get new_user_admin_path
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get show should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)    
    user = users(:visionpulse)
    get user_admin_path(user)
    assert_response :success
  end

  test "get show should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    user = users(:visionpulse)
    get user_admin_path(user)
    assert_redirected_to accounts_path
  end

  test "get show should redirect to login when not logged in" do  
    user = users(:visionpulse)
    get user_admin_path(user)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get edit should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)    
    user = users(:visionpulse)
    get edit_user_admin_path(user)
    assert_response :success
  end

  test "get edit should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    user = users(:visionpulse)
    get edit_user_admin_path(user)
    assert_redirected_to accounts_path
  end

  test "get edit should redirect to login when not logged in" do  
    user = users(:visionpulse)
    get edit_user_admin_path(user)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get delete should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)    
    user = users(:visionpulse)
    get delete_user_admin_path(user)
    assert_response :success
  end

  test "get delete should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    user = users(:visionpulse)
    get delete_user_admin_path(user)
    assert_redirected_to accounts_path
  end

  test "get delete should redirect to login when not logged in" do  
    user = users(:visionpulse)
    get delete_user_admin_path(user)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get change password should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)    
    user = users(:visionpulse)
    get "/user_admin/#{user.id}/edit_password"
    assert_response :success
  end

  test "get change password should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    user = users(:visionpulse)
    get "/user_admin/#{user.id}/edit_password"
    assert_redirected_to accounts_path
  end

  test "get change password should redirect to login when not logged in" do  
    user = users(:visionpulse)
    get "/user_admin/#{user.id}/edit_password"
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  # Controller Method Verification Tests

  test "post create should work with valid data" do
    usera = users(:superuser)
    log_in_as(usera)
    assert_difference('User.count', 1) do
      post user_admins_url, params: { user: { 
        fname: "Vibe",
        lname: "Check",
        email: "vibecheck@ghost.com",
        username: "vibecheck",
        password: "abcdef",
        password_confirmation: "abcdef"
        } 
      }
    end
    assert_redirected_to %r(/user_admins/[0-9]+)
  end

  test "delete should remove user with no accounts when logged in" do
    user = users(:superuser)
    log_in_as(user)
    user = users(:noaccountuser)
    assert_difference('User.count', -1) do
      delete user_admin_path(user)
    end
    assert_redirected_to user_admins_path
  end

  test "delete should not remove user with assigned accounts" do
    user = users(:superuser)
    log_in_as(user)
    user = users(:visionpulse)
    assert_no_difference('User.count') do
      delete user_admin_path(user)
    end
    assert_redirected_to user_admins_path
  end

  test "delete should not remove user when not logged in" do
    user = users(:supercarboy)
    assert_no_difference('User.count') do
      delete user_admin_path(user)
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "should be able to update user with valid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    user = users(:visionpulse)
    new_fname = "Patrick"
    new_lname = "Pickles"
    assert_no_difference('User.count') do
      patch user_admin_path(user), params: { user: { fname: new_fname, lname: new_lname} }
    end
    assert_redirected_to user_admin_path(user)
    user.reload
    assert_equal new_fname, user.fname
    assert_equal new_lname, user.lname
  end

  test "should not be able to update user with valid data when not logged in" do
    user = users(:visionpulse)
    old_fname = user.fname
    new_fname = "Patrick"
    assert_no_difference('User.count') do
      patch user_admin_path(user), params: { user: { fname: new_fname } }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
    user.reload
    assert_equal old_fname, user.fname
  end

  test "should be able to update user password with valid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    user = users(:visionpulse)
    new_pw_c = new_pw = "passnewwoord"
    old_pw = user.password_digest
    assert_no_difference('User.count') do
      patch "/user_admin/#{user.id}/edit_password_action", params: { user: { password: new_pw, password_confirmation: new_pw_c} }
    end
    assert_redirected_to user_admin_path(user)
    user.reload
    assert_not_equal user.password_digest, old_pw
  end

  test "should not be able to update user password with valid data when not logged in" do
    user = users(:visionpulse)
    new_pw_c = new_pw = "passnewwoord"
    old_pw = user.password_digest
    assert_no_difference('User.count') do
      patch "/user_admin/#{user.id}/edit_password_action", params: { user: { password: new_pw, password_confirmation: new_pw_c} }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
    user.reload
    assert_equal user.password_digest, old_pw
  end


end
