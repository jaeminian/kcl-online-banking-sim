## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class AccountAdminsControllerTest < ActionDispatch::IntegrationTest
  # Access Tests for Index, New, Show, Edit, Delete Views
  test "get index should only work when logged in" do
    user = users(:superuser)
    log_in_as(user)
    get account_admins_url
    assert_response :success
  end

  test "get index should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get account_admins_url
    assert_redirected_to accounts_path
  end

  test "get index should redirect to login if not logged in" do
    get account_admins_url
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get new should only work when logged in" do
    user = users(:superuser)
    log_in_as(user)
    get new_account_admin_url
    assert_response :success
  end

  test "get new should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get new_account_admin_url
    assert_redirected_to accounts_path
  end

  test "get new should redirect to login if not logged in" do
    account = accounts(:one)
    get new_account_admin_url
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get show should only work when an account is selected" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    get account_admin_url(account)
    assert_response :success
  end

  test "get show should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    get account_admin_url(account)
    assert_redirected_to accounts_path
  end

  test "get show should redirect to login if not logged in" do
    account = accounts(:one)
    get account_admin_url(account)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get show should display an error page if account does not exist" do
    user = users(:superuser)
    log_in_as(user)
    get account_admin_url(9000)
    assert_template :"error_pages/index"
  end

  test "get edit should only work when an account is selected" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    get edit_account_admin_url(account)
    assert_response :success
  end

  test "get edit should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    get edit_account_admin_url(account)
    assert_redirected_to accounts_path
  end

  test "get edit should redirect to login if not logged in" do
    account = accounts(:one)
    get edit_account_admin_url(account)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get edit should display an error page if account does not exist" do
    user = users(:superuser)
    log_in_as(user)
    get edit_account_admin_url(9000)
    assert_template :"error_pages/index"
  end

  test "get delete should only work when an account is selected" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    get delete_account_admin_path(account)
    assert_response :success
  end

  test "get delete should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    get delete_account_admin_path(account)
    assert_redirected_to accounts_path
  end

  test "get delete should redirect to login if not logged in" do
    account = accounts(:one)
    get delete_account_admin_path(account)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get delete should display an error page if account does not exist" do
    user = users(:superuser)
    log_in_as(user)
    get delete_account_admin_path(9000)
    assert_template :"error_pages/index"
  end


  # Controller Method Verification Tests
  test "post create should work with valid data" do
    usera = users(:superuser)
    log_in_as(usera)
    assert_difference('Account.count', 1) do
      post account_admins_url, params: { account: {
        user_id: users(:visionpulse).id,
        accnumber: "123456",
        sortcode: "12-34-56",
        accname: "testaccountname",
        curr_id: currencies(:one).id
        }
      }
    end
    assert_redirected_to account_admins_path
  end

  test "post create should not work with invalid data" do
    usera = users(:superuser)
    log_in_as(usera)
    assert_no_difference('Account.count') do
      post account_admins_url, params: { account: {
        user_id: users(:visionpulse).id,
        accnumber: "123456",
        sortcode: "",
        accname: "testaccountname",
        curr_id: currencies(:one).id
        }
      }
    end
    assert_template :"account_admins/_error_acc_admin"
  end

  test "post create should not work when not logged in" do
    assert_no_difference('Account.count') do
      post account_admins_url, params: { account: {
        user_id: users(:visionpulse).id,
        accnumber: "123456",
        sortcode: "12-34-56",
        accname: "testaccountname",
        curr_id: currencies(:one).id
        }
      }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "delete should remove account when logged in" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    assert_difference('Transaction.count', -1) do
      assert_difference('Account.count', -1) do
        delete account_admin_path(account)
      end
    end
    assert_redirected_to account_admins_path
  end

  test "delete should not remove account when not logged in" do
    account = accounts(:one)
    assert_no_difference('Account.count') do
      delete account_admin_path(account)
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "should be able to update account with valid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    new_accname = "mynewname"
    new_currency = 1
    assert_no_difference('Account.count') do
      patch account_admin_path(account), params: { account: { accname: new_accname, curr_id: new_currency} }
    end
    assert_redirected_to account_admin_path(account)
    account.reload
    assert_equal new_accname, account.accname
    assert_equal new_currency, account.curr_id
  end

  test "should not be able to update account with invalid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    old_accname = account.accname
    new_accname = ""
    assert_no_difference('Account.count') do
      patch account_admin_path(account), params: { account: { accname: new_accname } }
    end
    assert_template :"account_admins/_error_acc_admin"
    account.reload
    assert_equal old_accname, account.accname
  end

  test "should not be able to update account with valid data when not logged in" do
    account = accounts(:one)
    old_accname = account.accname
    new_accname = "mynewname"
    assert_no_difference('Account.count') do
      patch account_admin_path(account), params: { account: { accname: new_accname } }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
    account.reload
    assert_equal old_accname, account.accname
  end
end
