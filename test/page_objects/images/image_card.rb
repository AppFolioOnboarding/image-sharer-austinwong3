module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def tags
        output = []
        node.all('a.tag').each do |tag|
          output << tag.text
        end
        output
      end

      def click_tag!(tag_name)
        node.click_on(tag_name)
        window.change_to(IndexPage)
      end

      def view!
        node.find(:css, 'img').click
        window.change_to(ShowPage)
      end
    end
  end
end
