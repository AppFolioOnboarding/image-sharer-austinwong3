require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    img = Image.new(url: 'https://picsum.photos/id/237/200/300')

    assert_predicate img, :valid?
  end

  def test_image__invalid_if_blank
    img = Image.new(url: '')

    assert_not_predicate img, :valid?
    assert_equal 'can\'t be blank', img.errors.messages[:url].first
  end

  def test_image__invalid_if_not_url
    img = Image.new(url: 'asdf')

    assert_not_predicate img, :valid?
    assert_equal 'is invalid', img.errors.messages[:url].first
  end
end
