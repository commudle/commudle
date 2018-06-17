require 'test_helper'

class DataFormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get data_forms_index_url
    assert_response :success
  end

  test "should get new" do
    get data_forms_new_url
    assert_response :success
  end

  test "should get create" do
    get data_forms_create_url
    assert_response :success
  end

  test "should get edit" do
    get data_forms_edit_url
    assert_response :success
  end

  test "should get update" do
    get data_forms_update_url
    assert_response :success
  end

end
