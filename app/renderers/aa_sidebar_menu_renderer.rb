# app/renderers/aa_sidebar_menu_renderer.rb
module ActiveAdmin
  module Menu
    class ShopifySidebarRenderer < ActiveAdmin::MenuRenderer

      def to_html
        content = menu.items.map { |item| render_item(item) }.join
        content_tag :div, class: "aa-sidebar" do
          content_tag(:ul, content.html_safe, class: "aa-sidebar-nav")
        end
      end

      private

      def render_item(item)
        classes = []
        classes << "active" if current?(item)

        content_tag :li, class: classes.join(" ") do
          link_to item.label, url_for(item.url)
        end
      end

      def current?(item)
        request.fullpath.start_with?(url_for(item.url))
      end

    end
  end
end
