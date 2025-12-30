## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "get profile should only work when logged in" do
    user = users(:visionpulse)
    log_in_as(user)
    get "/profile"
    assert_response :success
  end

  test "get profile should redirect to login when not logged in" do  
    get "/profile"
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "post to user secure with value not 0 should enable two factor auth" do 
    user = users(:visionpulse)
    log_in_as(user)
    olpw = user.securelogin
    assert_no_difference('User.count') do
      post "/user/secure", params: {seclogin: "picklerick"}
    end
    assert_redirected_to "/profile"
    user.reload
    assert_not_equal olpw, user.securelogin
  end

  test "post to user secure with value 0 should disable two factor auth" do 
    user = users(:visionpulse)
    log_in_as(user)
    olpw = user.securelogin
    assert_no_difference('User.count') do
      post "/user/secure", params: {seclogin: "picklerick"}
    end
    assert_redirected_to "/profile"
    user.reload
    assert_not_equal olpw, user.securelogin
  end

  test "post to user secure with blank values should not be invalid" do 
    user = users(:visionpulse)
    log_in_as(user)
    olpw = user.securelogin
    assert_no_difference('User.count') do
      post "/user/secure", params: {seclogin: ""}
    end
    user.reload
    assert_equal olpw, user.securelogin
  end

end
