require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    img = Image.new(url: 'https://picsum.photos/id/237/200/300', tag_list: 'cool, nice')

    assert_predicate img, :valid?
  end

  def test_image__invalid_if_no_tags
    img = Image.new(url: 'https://picsum.photos/id/237/200/300', tag_list: '')

    assert_not_predicate img, :valid?
    assert_equal 'can\'t be blank', img.errors.messages[:tag_list].first
  end

  def test_image__invalid_if_no_url
    img = Image.new(url: '', tag_list: 'cool, nice')

    assert_not_predicate img, :valid?
    assert_equal 'can\'t be blank', img.errors.messages[:url].first
  end

  def test_image__invalid_if_not_valid_url
    img = Image.new(url: 'asdf', tag_list: 'cool, nice')

    assert_not_predicate img, :valid?
    assert_equal 'is invalid', img.errors.messages[:url].first
  end
end
