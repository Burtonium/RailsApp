require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:matt)
    @non_admin = users(:rick)
    @inactive_user = users(:morty)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "inactive users don't show up for regular users" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a[href=?]', user_path(@inactive_user), 0
    get user_path(@inactive_user)
    assert_redirected_to root_path
  end
  
  test "inactive users show up for admin users" do
    log_in_as(@admin)
    get users_path
    assert_select 'a[href=?]', user_path(@inactive_user), 
                               text: @inactive_user.name
    get user_path(@inactive_user)
    assert_template :show
  end
  
  
  
end
