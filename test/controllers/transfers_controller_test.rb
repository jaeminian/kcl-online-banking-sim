## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class TransfersControllerTest < ActionDispatch::IntegrationTest

  test "get new transfer should only work when logged in" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    get "/transfers/#{account.id}/new"
    assert_response :success
  end

  test "get new transfer should give a warning when logged in as administrator" do
    user = users(:superuser)
    log_in_as(user)
    account = accounts(:one)
    get "/transfers/#{account.id}/new"
    assert_template :"error_pages/index"
  end

  test "get new transfer redirect to login when not logged in" do
    account = accounts(:one)
    get "/transfers/#{account.id}/new"
    assert_redirected_to controller: "sessions", action: "new"
  end


  test "post create should work with valid data" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    assert_difference('Transaction.count', 1) do
      post "/transfers/#{account.id}/new", params: { transaction: {
        amount: 100,
        receiver: "Travel"
        }
      }
    end
    assert_redirected_to "/transactions/#{account.id}"
  end

  test "post create should not work with invalid data" do
    user = users(:visionpulse)
    log_in_as(user)
    account = accounts(:one)
    assert_no_difference('Transaction.count') do
      post "/transfers/#{account.id}/new", params: { transaction: {
        amount: "abc",
        receiver: 100
        }
      }
    end
  end

  test "post create should not work when not logged in" do
    account = accounts(:one)
    assert_no_difference('Transaction.count') do
      post "/transfers/#{account.id}/new", params: { transaction: {
        amount: 100,
        receiver: "Travel"
        }
      }
    end
    assert_redirected_to login_path
  end


end