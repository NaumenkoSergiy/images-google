require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  file_name = 'lena.jpg'
  photo_attributes = { file_path: [fixture_path, file_name].join(''), title: 'Lena', keywords: 'one, two, three' }
  album, photo = nil

  before(:all) do
    session[:code] = ENV['CODE']
    session[:token] = AuthHeader

    album = Picasa::API::Album.new(user_id: 's.naumenko@active-bridge.com', access_token: AccessToken).create({title: 'test'})
    photo = Picasa::API::Photo.new(user_id: 's.naumenko@active-bridge.com', access_token: AccessToken).create(album.id, photo_attributes)
  end

  after(:all) do
    client = Picasa::Client.new(user_id: 's.naumenko@active-bridge.com', access_token: AccessToken)
    client.album.show(album.id).photos.each do |photo|
      Picasa::API::Photo.new(user_id: 's.naumenko@active-bridge.com', access_token: AccessToken).delete(album.id, photo.id)
    end
    Picasa::API::Album.new(user_id: 's.naumenko@active-bridge.com', access_token: AccessToken).delete(album.id)
  end

  test "destroy photo" do
    current_user = users(:one)
    sign_in current_user
    client = Picasa::Client.new(user_id: current_user.email, access_token: AccessToken)

    delete :destroy, id: photo.id, album_id: album.id
    assert_equal nil, client.album.show(album.id).photos.find { |p| p.id == photo.id }
  end

  test "create photo" do
    current_user = users(:one)
    sign_in current_user
    client = Picasa::Client.new(user_id: current_user.email, access_token: AccessToken)
    upload_file = Rack::Test::UploadedFile.new([fixture_path, file_name].join(''), 'image/jpg')
    post :create, album_id: album.id, file: upload_file
    assert_equal file_name, client.album.show(album.id).photos.last.title
  end

  test "destroy another user's photo" do
    current_user = users(:two)
    sign_in current_user

    delete :destroy, id: photo.id, album_id: album.id
    assert_equal 'No photo found.', flash[:error]
    assert_redirected_to root_path
  end

  test "create photo for another user's" do
    current_user = users(:two)
    sign_in current_user

    upload_file = Rack::Test::UploadedFile.new([fixture_path, file_name].join(''), 'image/jpg')
    post :create, album_id: album.id, file: upload_file
    assert_equal 'No album found.', flash[:error]
    assert_redirected_to root_path
  end

  test 'create photo for non-authorized user' do
    upload_file = Rack::Test::UploadedFile.new([fixture_path, file_name].join(''), 'image/jpg')
    post :create, album_id: album.id, file: upload_file
    assert_equal true, flash[:error].present?
    assert_redirected_to root_path
  end

  test 'destroy photo for non-authorized user' do
    delete :destroy, id: photo.id, album_id: album.id
    assert_equal true, flash[:error].present?
    assert_redirected_to root_path
  end
end
