require 'test_helper'

class V1::SessionsControllerTest < ActionDispatch::IntegrationTest

  test 'should create session' do
    params = {
      email_address: users(:one).email_address,
      password: 'password'
    }

    post v1_login_path params: params
    assert_response :success
  end

  test 'should not create session when credentials are invalid' do
    params = {
      email_address: users(:one).email_address,
      password: 'invalid'
    }

    post v1_login_path params: params
    assert_response :unauthorized
  end

  test 'should destroy session' do
    headers = {
      'Authorization' => "Bearer #{sessions(:one).token}"
    }

    assert_changes -> { Session.count } do
      delete v1_logout_path, headers: headers
    end
    assert_nil Current.session
    assert_response :success
  end

  test 'should not destroy session with an invalid token' do
    headers = {
      'Authorization' => 'Bearer invalid'
    }

    delete v1_logout_path, headers: headers
    assert_response :unauthorized
  end

end
