require 'test_helper'

class V1::PasswordsControllerTest < ActionDispatch::IntegrationTest

  test 'create - should send password reset instructions' do
    assert_enqueued_emails 1 do
      post v1_passwords_path, params: { email_address: users(:one).email_address }
      assert_response :success
    end

    response_data = JSON.parse(response.body)
    assert_equal 'Password reset instructions sent', response_data['message']
  end

  test 'create - should not send password reset instructions if user does not exist' do
    params = { email_address: 'nonexistent@example.com' }

    assert_no_enqueued_emails do
      post v1_passwords_path, params: params
      assert_response :not_found
    end
  end

  test 'update - should reset the password' do
    user = users(:one)
    token = user.password_reset_token
    new_password = 'newpassword'

    headers = { Authorization: "Bearer #{token}" }
    params = {
      password: new_password,
      password_confirmation: new_password
    }

    put v1_password_path(token), params: params, headers: headers
    assert_response :success

    assert user.reload.authenticate(new_password)
    assert_equal 0, user.sessions.count
  end

  test 'update - should not reset the password if passwords do not match' do
    user = users(:one)
    token = user.password_reset_token
    new_password = 'newpassword'

    headers = { Authorization: "Bearer #{token}" }
    params = {
      password: new_password,
      password_confirmation: 'wrongpassword',
      token: token
    }

    put v1_password_path(token), params: params, headers: headers
    assert_response :unprocessable_entity

    response_data = JSON.parse(response.body)
    assert_equal ["Password confirmation doesn't match Password"], response_data['error']
  end

  private

  def assert_notice(text)
    assert_select 'div', /#{text}/
  end

end
