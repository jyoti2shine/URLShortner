require 'test_helper'

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @short_url = short_urls(:one)
  end

  test "should get index" do
    get short_urls_url, as: :json
    assert_response :success
  end

  test "should create short_url" do
    assert_difference('ShortUrl.count') do
      post short_urls_url, params: { short_url: { original_url: @short_url.original_url, shorty: @short_url.shorty, user_id: @short_url.user_id, visits: @short_url.visits } }, as: :json
    end

    assert_response 201
  end

  test "should show short_url" do
    get short_url_url(@short_url), as: :json
    assert_response :success
  end

  test "should update short_url" do
    patch short_url_url(@short_url), params: { short_url: { original_url: @short_url.original_url, shorty: @short_url.shorty, user_id: @short_url.user_id, visits: @short_url.visits } }, as: :json
    assert_response 200
  end

  test "should destroy short_url" do
    assert_difference('ShortUrl.count', -1) do
      delete short_url_url(@short_url), as: :json
    end

    assert_response 204
  end
end
