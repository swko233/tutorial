require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # 無効なユーザーは保存されないことを確かめる
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'form[action="/signup"]' 
  end

  #  有効なユーザーが保存されることを確かめる
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "rails",
                                         email: "user@valid.com",
                                         password:              "hogehoge",
                                         password_confirmation: "hogehoge" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
  end
end