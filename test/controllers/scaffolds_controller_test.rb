require "test_helper"

class ScaffoldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scaffold = scaffolds(:one)
  end

  test "should get index" do
    get scaffolds_url
    assert_response :success
  end

  test "should get new" do
    get new_scaffold_url
    assert_response :success
  end

  test "should create scaffold" do
    assert_difference("Scaffold.count") do
      post scaffolds_url, params: { scaffold: {  } }
    end

    assert_redirected_to scaffold_url(Scaffold.last)
  end

  test "should show scaffold" do
    get scaffold_url(@scaffold)
    assert_response :success
  end

  test "should get edit" do
    get edit_scaffold_url(@scaffold)
    assert_response :success
  end

  test "should update scaffold" do
    patch scaffold_url(@scaffold), params: { scaffold: {  } }
    assert_redirected_to scaffold_url(@scaffold)
  end

  test "should destroy scaffold" do
    assert_difference("Scaffold.count", -1) do
      delete scaffold_url(@scaffold)
    end

    assert_redirected_to scaffolds_url
  end
end
