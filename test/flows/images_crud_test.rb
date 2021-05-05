require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'delete an image' do
    black_dog_url = 'https://picsum.photos/id/237/200/300'
    city_url = 'https://picsum.photos/id/238/200/300'
    Image.create!([
      { url: black_dog_url, tag_list: 'puppy, doggo' },
      { url: city_url, tag_list: 'skyscraper, sky' }
    ])

    index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, index_page.images.count
    assert index_page.showing_image?(url: black_dog_url)
    assert index_page.showing_image?(url: city_url)

    image_to_delete = index_page.images.find do |image|
      image.url == black_dog_url
    end

    show_page = image_to_delete.view!

    show_page.delete do |confirm_dialog|
      assert_equal 'Are you sure you want to delete this image?', confirm_dialog.text
      confirm_dialog.dismiss
    end

    index_page = show_page.delete_and_confirm!
    assert_equal 1, index_page.images.count
    assert_not index_page.showing_image?(url: black_dog_url)
    assert index_page.showing_image?(url: city_url)
  end
end
