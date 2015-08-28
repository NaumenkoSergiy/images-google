require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "destroy photo" do
    sign_in users(:one)

    attributes = { file_path: [fixture_path, 'lena.jpg'].join(''), title: 'Lena', keywords: 'one, two, three' }

    album = Picasa::API::Album.new(user_id: users(:one).email, access_token: ENV['ACCESS_TOKEN']).create({title: 'test'})
    photo = Picasa::API::Photo.new(user_id: users(:one).email, access_token: ENV['ACCESS_TOKEN']).create(album.id, attributes)

    assert_equal "Lena", photo.title
    assert_equal "one, two, three", photo.media.keywords
    delete :destroy, id: photo.id, album_id: album.id
    assert_response :success
  end

  test "create photo" do
    sign_in users(:one)

    attributes = { file_path: [fixture_path, 'lena.jpg'].join(''), title: 'Lena', keywords: 'one, two, three' }

    album = Picasa::API::Album.new(user_id: "s.naumenko@active-bridge.com", access_token: ENV['ACCESS_TOKEN']).create({title: 'test'})
    photo = Picasa::API::Photo.new(user_id: "s.naumenko@active-bridge.com", access_token: ENV['ACCESS_TOKEN']).create(album.id, attributes)

    assert_equal "Lena", photo.title
    assert_equal "one, two, three", photo.media.keywords
    delete :create, album_id: album.id
    assert_response :success
    assert_equal "Lena", photo.title
    assert_equal "one, two, three", photo.media.keywords
  end
end
