require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without email and password' do
    user = User.new
    assert_not user.save
  end

  test 'should save user' do
    user = User.new(email: Faker::Internet.email, password: Faker::Internet.password(10, 20))
    assert user.save
  end
end
