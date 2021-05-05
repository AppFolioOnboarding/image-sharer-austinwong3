require_relative './image_card'

module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :root

      collection :images, locator: '.image-cards', item_locator: '.image_card', contains: ImageCard do
        def view!
          node.find('img').click
          window.change_to(ShowPage)
        end
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          tags_match = tags ? image.tags == tags : true
          image.url == url && tags_match
        end
      end

      def clear_tag_filter!
        node.click_on('Home')
        window.change_to(IndexPage)
      end
    end
  end
end
