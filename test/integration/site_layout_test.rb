require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @non_admin = users(:archer)
  end

  test "layout links for non-logged in users" do
    get root_path
    assert_template 'static_pages/home'

    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path

    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "layout links for logged in users" do
    log_in_as(@non_admin)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@non_admin)
    assert_select "a[href=?]", edit_user_path(@non_admin)
    assert_select "a[href=?]", logout_path

    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
