## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class CurrencyAdminsControllerTest < ActionDispatch::IntegrationTest

  # Access Tests for Index, New, Show, Edit, Delete Views
  test "get index should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)
    get currency_admins_path
    assert_response :success
  end

  test "get index should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get currency_admins_path
    assert_redirected_to accounts_path
  end

  test "get index should redirect to login when not logged in" do
    get currency_admins_path
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get new should only work when logged in as admin" do
    user = users(:superuser)
    log_in_as(user)
    get new_currency_admin_path
    assert_response :success
  end

  test "get new should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get new_currency_admin_path
    assert_redirected_to accounts_path
  end

  test "get new should redirect to login when not logged in" do
    get new_currency_admin_path
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get show should only work when logged in as admin and a currency is selected" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    get currency_admin_path(currency)
    assert_response :success
  end

  test "get show should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    currency = currencies(:one)
    get currency_admin_path(currency)
    assert_redirected_to accounts_path
  end

  test "get show should redirect to login when not logged in" do
    currency = currencies(:one)
    get currency_admin_path(currency)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get edit should only work when logged in as admin and a currency is selected" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    get edit_currency_admin_path(currency)
    assert_response :success
  end

  test "get edit should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    currency = currencies(:one)
    get edit_currency_admin_path(currency)
    assert_redirected_to accounts_path
  end

  test "get edit should redirect to login when not logged in" do
    currency = currencies(:one)
    get edit_currency_admin_path(currency)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "get delete should only work when logged in as admin and a currency is selected" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    get delete_currency_admin_path(currency)
    assert_response :success
  end

  test "get delete should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    currency = currencies(:one)
    get delete_currency_admin_path(currency)
    assert_redirected_to accounts_path
  end

  test "get delete should redirect to login when not logged in" do
    currency = currencies(:one)
    get delete_currency_admin_path(currency)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  # Controller Method Verification Tests

  test "post create should work with valid data" do
    user = users(:superuser)
    log_in_as(user)
    assert_difference('Currency.count', 1) do
      post currency_admins_url, params: { currency: {
        bigname: "AmericanDollar",
        shortname: "USD"
        }
      }
    end
    assert_redirected_to %r(/currency_admins/[0-9]+)
  end


  test "post create should not work with invalid data" do
    user = users(:superuser)
    log_in_as(user)
    assert_no_difference('Currency.count') do
      post currency_admins_url, params: { currency: {
        bigname: "AmericanDollar",
        shortname: ""
        }
      }
    end
    assert_template :"currency_admins/_error_cur_admin"
  end

  test "post create should not work when not logged in" do
    assert_no_difference('Currency.count') do
      post currency_admins_url, params: { currency: {
        bigname: "AmericanDollar",
        shortname: "USD"
        }
      }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end


  test "delete should remove currency when logged in and no account is using it" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    account = accounts(:one)
    assert_difference('Currency.count', -1) do
      delete account_admin_path(account)
      delete currency_admin_path(currency)
    end
    assert_redirected_to currency_admins_path
  end

  test "delete should not remove currency when logged in and an account is using it" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    assert_no_difference('Currency.count') do
      delete currency_admin_path(currency)
    end
    assert_redirected_to currency_admins_path
  end

  test "delete should not remove currency when not logged in" do
    currency = currencies(:one)
    assert_no_difference('Currency.count') do
      delete currency_admin_path(currency)
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "should be able to update currency with valid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    new_bigname = "CanadianDollar"
    new_shortname = "CAD"
    assert_no_difference('Currency.count') do
      patch currency_admin_path(currency), params: { currency: { bigname: new_bigname, shortname: new_shortname} }
    end
    assert_redirected_to currency_admin_path(currency)
    currency.reload
    assert_equal new_bigname, currency.bigname
    assert_equal new_shortname, currency.shortname
  end

  test "should not be able to update currency with invalid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    currency = currencies(:one)
    old_bigname = currency.bigname
    new_bigname = 100
    old_shortname = currency.shortname
    new_shortname = ""
    assert_no_difference('Currency.count') do
      patch currency_admin_path(currency), params: { currency: { bigname: new_bigname, shortname: new_shortname} }
    end
    assert_template :"currency_admins/_error_cur_admin"
    currency.reload
    assert_equal old_bigname, currency.bigname
    assert_equal old_shortname, currency.shortname
  end

  test "should not be able to update currency with valid data when not logged in" do
    currency = currencies(:one)
    old_bigname = currency.bigname
    new_bigname = "CanadianDollar"
    old_shortname = currency.shortname
    new_shortname = "CAD"
    assert_no_difference('Currency.count') do
      patch currency_admin_path(currency), params: { currency: { bigname: new_bigname, shortname: new_shortname} }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
    currency.reload
    assert_equal old_bigname, currency.bigname
    assert_equal old_shortname, currency.shortname
  end

end