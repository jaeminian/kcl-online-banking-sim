## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class ErrorPagesControllerTest < ActionDispatch::IntegrationTest

# Access Tests for show, edit, delete for transactions
  test "get show should only work when the account is belong to the " do

   user = users(:superuser)
   log_in_as(user)
   get "/transactions/9"
   assert_template :"error_pages/index"
 end

 test "get edit should only work when the account is belong to the " do

   user = users(:superuser)
   log_in_as(user)
   get "/transactions/9"
   assert_template :"error_pages/index"
  end

  test "get delete should only work when the account is belong to the " do


    user = users(:superuser)
    log_in_as(user)
    get "/transactions/9"
    assert_template :"error_pages/index"
  end



end
