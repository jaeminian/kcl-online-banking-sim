## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class TransactionAdminsControllerTest < ActionDispatch::IntegrationTest

  # tests for index, show, edit and delete actions
  test "should get index if user is admin" do
   user = users(:superuser)
   log_in_as(user)
   get transaction_admins_path
   assert_response :success
  end

  test "should not get index if user is normal user" do
    user = users(:supercarboy)
    log_in_as(user)
    get transaction_admins_path
    assert_redirected_to accounts_path
  end

  test "should not get index if user is not logged in" do
    get transaction_admins_path
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to '/login'
  end

  test "should show the transaction if user is admin" do
   user = users(:superuser)
   log_in_as(user)
   account = accounts(:one)
   get transaction_admin_path(account)
   assert_response :success
  end

  test "should not show the transaction if user is normal user" do
    user = users(:supercarboy)
    log_in_as(user)
    account = accounts(:two)
    get transaction_admin_path(account)
    assert_redirected_to accounts_path
  end

  test "should not get show if user is not logged in" do
    transaction = transactions(:one)
    get transaction_admin_path(transaction)
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to '/login'
  end

   test "should get new if user is admin" do
     user = users(:superuser)
     log_in_as(user)
     get new_transaction_admin_path
     assert_response :success
   end

   test "should not get new if user is normal user" do
     user = users(:supercarboy)
     log_in_as(user)
     get new_transaction_admin_path
     assert_redirected_to accounts_path
   end

   test "should not get new if user is not logged in" do
     get new_transaction_admin_path
     assert_redirected_to accounts_path
     follow_redirect!
     assert_redirected_to '/login'
   end

   test "should get edit if user is admin" do
     user = users(:superuser)
     log_in_as(user)
     transaction = transactions(:one)
     get edit_transaction_admin_path(transaction)
     assert_response :success
   end

   test "should not get edit if user is normal user" do
     user = users(:supercarboy)
     log_in_as(user)
     transaction = transactions(:one)
     get edit_transaction_admin_path(transaction)
     assert_redirected_to accounts_path
   end

   test "should not get edit if user is not logged in" do
     transaction = transactions(:one)
     get edit_transaction_admin_path(transaction)
     assert_redirected_to accounts_path
     follow_redirect!
     assert_redirected_to '/login'
   end

   test "should get delete if user is admin" do
     user = users(:superuser)
     log_in_as(user)
     transaction = transactions(:one)
     get delete_transaction_admin_path(transaction)
     assert_response :success
   end

   test "should not get delete if user is normal user" do
     user = users(:supercarboy)
     log_in_as(user)
     transaction = transactions(:one)
     get delete_transaction_admin_path(transaction)
     assert_redirected_to accounts_path
   end

   test "should not get delete if user is not logged in" do
     transaction = transactions(:one)
     get delete_transaction_admin_path(transaction)
     assert_redirected_to accounts_path
     follow_redirect!
     assert_redirected_to '/login'
   end

#tests for create, update and destroy
    test "should post create if amount is debit and data is valid" do
      user = users(:superuser)
      log_in_as(user)
      assert_difference('Transaction.count', 1) do
        post transaction_admins_path, params: { transaction: {
          receiver: "mishata",
          amount: 1000,
          account_id: accounts(:one).id
        }
      }
      assert_redirected_to transaction_admins_path
      end
    end

    test "should post create if amount is credit is valid" do
      user = users(:superuser)
      log_in_as(user)
      assert_difference('Transaction.count', 1) do
        post transaction_admins_path, params: { transaction: {
          receiver: "mishata",
          amount: -1000,
          account_id: accounts(:one).id
        }
      }
      assert_redirected_to transaction_admins_path
      end
    end

    test "should not post create if data is invalid" do
      user = users(:superuser)
      log_in_as(user)
      assert_no_difference('Transaction.count') do
        post transaction_admins_path, params: { transaction: {
          receiver: "",
          amount: -1000,
          account_id: accounts(:one).id
        }
      }
      assert_template 'new'
      end
    end

    test "should not post create if user is not logged in" do
      assert_no_difference('Transaction.count') do
        post transaction_admins_path, params: { transaction: {
          receiver: "",
          amount: -1000,
          account_id: accounts(:one).id
          }
        }
      end
      assert_redirected_to accounts_path
      follow_redirect!
      assert_redirected_to '/login'
    end

    test "should update if amount is debit and data is valid" do
      user = users(:superuser)
      log_in_as(user)
      transaction = transactions(:one)
      amount_changed = 5000
      patch transaction_admin_path(transaction), params: { transaction: {amount: amount_changed,}}
      assert_redirected_to transaction_admin_path(transaction)
      transaction.reload
      assert_equal transaction.amount, amount_changed
    end

    test "should update if amount is credit and data is valid" do
      user = users(:superuser)
      log_in_as(user)
      transaction = transactions(:one)
      amount_changed = -5000
      patch transaction_admin_path(transaction), params: { transaction: {amount: amount_changed,}}
      assert_redirected_to transaction_admin_path(transaction)
      transaction.reload
      assert_equal transaction.amount, amount_changed
    end

    test "should not update if data is invalid" do
      user = users(:superuser)
      log_in_as(user)
      transaction = transactions(:one)
      amount_saved = transaction.amount
      patch transaction_admin_path(transaction), params: { transaction: {amount: ""}}
      assert_template 'edit'
      transaction.reload
      assert_equal transaction.amount, amount_saved
    end

    test "should not update if user is not logged in" do
      transaction = transactions(:one)
      amount_changed = -5000
      assert_no_difference('Transaction.count') do
        patch transaction_admin_path(transaction), params: { transaction: {amount: amount_changed,}}
      end
      assert_redirected_to accounts_path
      follow_redirect!
      assert_redirected_to '/login'
    end

    test "should delete if such transaction exists" do
      user = users(:superuser)
      log_in_as(user)
      transaction = transactions(:one)
      assert_difference('Transaction.count', -1) do
        delete transaction_admin_path(transaction)
      end
      assert_redirected_to transaction_admins_path
    end

    test "should not delete if user is not logged in" do
      transaction = transactions(:one)
      assert_no_difference('Transaction.count') do
        delete transaction_admin_path(transaction)
      end
      assert_redirected_to accounts_path
      follow_redirect!
      assert_redirected_to '/login'
    end

    test "should be able to add random transactions with valid parameters" do
      user = users(:superuser)
      log_in_as(user)
      account = accounts(:one) 
      assert_difference('Transaction.count', 11) do
        patch "/transactions/#{account.id}/random"
      end
      assert_redirected_to account_admins_path
    end

    test "should not be able to add random transactions with valid parameters if not logged in" do
      account = accounts(:one) 
      assert_no_difference('Transaction.count') do
        patch "/transactions/#{account.id}/random"
      end
      assert_redirected_to accounts_path
      follow_redirect!
      assert_redirected_to '/login'
    end

end
