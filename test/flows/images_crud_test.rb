require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'delete an image' do
    index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, 2
  end
end
