require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(url: 'https://picsum.photos/id/237/200/300', tag_list: 'cool, nice')
    @image2 = Image.create!(url: 'https://picsum.photos/id/239/200/300', tag_list: 'sky, nature')
  end

  def test_index
    get images_path

    assert_select 'img', 2 do |images|
      assert_equal @image2.url, images.first.attributes['src'].value
      assert_equal @image.url, images.last.attributes['src'].value
    end
    assert_response :ok
  end

  def test_show
    get image_path(@image.id)

    assert_select 'img', 1 do |images|
      assert_equal @image.url, images.first.attributes['src'].value
    end
    assert_response :ok
  end

  def test_tag
    get tag_path(@image.tag_list[0])

    assert_select 'img', 1 do |images|
      assert_equal @image.url, images.first.attributes['src'].value
    end
    assert_response :ok
  end

  def test_tag__nonexistent
    get tag_path('fake')

    assert_select 'img', false
    assert_response :ok
  end

  def test_new
    get new_image_path

    assert_response :ok
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { url: 'https://picsum.photos/id/238/200/300', tag_list: 'cool, nice' }
      post images_path, params: { image: image_params }
    end

    assert_equal Image.last.url, 'https://picsum.photos/id/238/200/300'
    assert_equal Image.last.tag_list, %w[cool nice]
    assert_redirected_to image_path(Image.last)
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_params = { url: '' }
      post images_path, params: { image: image_params }
    end

    assert_template :new
  end

  def test_destroy
    assert_difference('Image.count', -1) do
      delete image_path(@image.id)
    end

    assert_redirected_to root_path
  end
end
