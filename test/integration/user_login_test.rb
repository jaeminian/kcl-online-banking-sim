## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

test "login with valid credentials" do
    get "/login"
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: { session: { username: "visionpulse", password: "abcdef123" } }
    assert_redirected_to accounts_path
    assert is_logged_in?
end

test "login with valid admin credentials" do
    get "/login"
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: { session: { username: "superuser", password: "abcdef123" } }
    assert_redirected_to "/admin"
    assert is_logged_in?
end

test "login with valid 2fa credentials" do
    get "/login"
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: { session: { username: "supercarboy", password: "abcdef123" } }
    assert_template 'sessions/secure'
    post "/loginsecure", params: { secure: "abcd" }
    assert_redirected_to accounts_path
    follow_redirect!
    assert_template 'accounts/index'
    assert is_logged_in?
end


test "login with valid credentials and invalid secondary password" do
    get "/login"
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: { session: { username: "supercarboy", password: "abcdef123" } }
    assert_template 'sessions/secure'
    post "/loginsecure", params: { secure: "dabcd" }
    assert_template 'sessions/secure'
    assert_not is_logged_in?
end

test "login with invalid credentials" do
    get "/login"
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: { session: { username: "visionpulse", password: "incorrectpw" } }
    assert_response :success
    assert_not is_logged_in?
end


end