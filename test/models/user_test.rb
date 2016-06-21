require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "John Doe", email: "matt@nephelo.co",
                     password: "foobar", password_confirmation: "foobar", 
                     language:"english")
  end
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do 
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email shouldn't be too long" do
  @user.email = "z" * 244 + "@example.com"
  assert_not @user.valid?
  end
  
  test "name shouldn't be too long" do
  @user.name = "Z" * 51
  assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation shouldn't accept invalid addresses" do
    invalid_addresses = %w[user@example USER@@foo.COM A_US-ER@foobar_org
                         first.last @exampl.co]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = 
                       " " * User::MIN_PASSWORD_LENGTH
    assert_not @user.valid?
  end
  
  test "password should be of minimum length" do
    @user.password = @user.password_confirmation = 
                       "z" * (User::MIN_PASSWORD_LENGTH - 1)
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "language should be present" do
    @user.language = ""
    assert_not @user.valid?
  end
  
  test "associated microposts should be deleted" do
    @user.save
    @user.microposts.create(content: "I am content")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
  