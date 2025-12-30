## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  # Access Tests for Index, New, Show, Edit, Delete Views
  test "get index should only work when logged in" do
    user = users(:visionpulse)
    log_in_as(user)
    get accounts_url
    assert_response :success
  end

  test "get index should redirect to login if not logged in " do
    get accounts_url
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get edit should only work when an account is selected" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    get edit_account_url(account)
    assert_response :success
  end

  test "get edit should redirect to login if not logged in" do
    account = accounts(:one)
    get edit_account_url(account)
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get edit should display an error page if account does not belong to the user " do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:two)
    get edit_account_url(account)
    assert_template :"error_pages/index"
  end

  test "get edit should display an error page if account does not exist to the user " do
    user = users(:visionpulse)
    log_in_as(user)
    get edit_account_url(9000)
    assert_template :"error_pages/index"
  end

  # Controller Method Verification Tests
  test "should be able to update account with valid data when logged in" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    new_accname = "mynewname"
    new_currency = 1
    assert_no_difference('Account.count') do
      patch account_path(account), params: { account: { accname: new_accname, curr_id: new_currency} }
    end
    assert_redirected_to "/transactions/#{account.id}"
    account.reload
    assert_equal new_accname, account.accname
    assert_equal new_currency, account.curr_id
  end

  test "should not be able to update account with invalid data when logged in" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    old_accname = account.accname
    new_accname = ""
    assert_no_difference('Account.count') do
      patch account_path(account), params: { account: { accname: new_accname } }
    end
    assert_template :"accounts/_error_acc"
    account.reload
    assert_equal old_accname, account.accname
  end

  test "should not be able to update account with valid data when not logged in" do
    account = accounts(:one)
    old_accname = account.accname
    new_accname = "mynewname"
    assert_no_difference('Account.count') do
      patch account_path(account), params: { account: { accname: new_accname } }
    end
    assert_redirected_to controller: "sessions", action: "new"
    account.reload
    assert_equal old_accname, account.accname
  end

end
