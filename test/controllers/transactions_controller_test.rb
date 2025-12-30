## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
   test "should get index if the account matches the user" do
     user = users(:visionpulse)
     log_in_as(user)
     account = accounts(:one)
     get "/transactions/#{account.id}"
     assert_response :success
   end

   test "should not get index because the account does not match the user" do
     user = users(:visionpulse)
     log_in_as(user)
     account = accounts(:two)
     get "/transactions/#{account.id}"
     assert_template 'error_pages/index'
   end

   test "should not get index if user is not logged in" do
     account = accounts(:two)
     get "/transactions/#{account.id}"
     assert_redirected_to '/login'
   end
end
