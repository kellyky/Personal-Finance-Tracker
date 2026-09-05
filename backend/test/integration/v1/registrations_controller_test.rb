# test/integration/v1/registrations_controller_test.rb
require 'test_helper'

class V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest

  test 'should create user' do
    params = {
      name: 'name',
      email_address: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    assert_changes -> { User.count } do
      post v1_registrations_path, params: params
    end

    assert_response :success
    assert_equal 'test@example.com', User.last.email_address
  end

  test 'should not create user with non-matching passwords' do
    params = {
      name: 'name',
      email_address: 'test@example.com',
      password: 'password',
      password_confirmation: 'pass'
    }

    assert_no_changes -> { User.count } do
      post v1_registrations_path, params: params
    end

    assert_response :unprocessable_content
  end

  test 'should not create user with duplicated email address' do
    params = {
      name: 'name',
      email_address: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post v1_registrations_path, params: params
    assert_response :success

    assert_no_changes -> { User.count } do
      post v1_registrations_path, params: params
    end

    assert_response :unprocessable_content
  end

  test 'should create user if name is not provided' do
    params = {
      email_address: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    assert_changes -> { User.count } do
      post v1_registrations_path, params: params
    end

    assert_response :success
    assert_equal 'test@example.com', User.last.email_address
  end

end

