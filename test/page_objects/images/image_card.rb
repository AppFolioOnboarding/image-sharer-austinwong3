module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def view!
        node.find(:css, 'img').click
        window.change_to(ShowPage)
      end
    end
  end
end
