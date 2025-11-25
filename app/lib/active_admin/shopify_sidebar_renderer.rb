module ActiveAdmin
  module Views
    # Custom renderer for the main/utility navigation to display as a sidebar.
    class ShopifySidebarRenderer < ActiveAdmin::Component
      builder_method :shopify_sidebar_renderer

      def build(menu, options = {})
        @menu = menu
        wrapper_options = options.dup
        wrapper_options[:class] = Array(wrapper_options[:class]).push("aa-sidebar").compact.join(" ")

        div(wrapper_options) do
          ul(class: "aa-sidebar-nav") do
            menu.items.each { |item| render_item(item) if display_item?(item) }
          end
        end
      end

      private

      attr_reader :menu

      def render_item(item)
        li(class: nav_classes(item)) do
          link_to menu_item_label(item), url_for(menu_item_url(item))
        end
      end

      def display_item?(item)
        helpers.render_in_context(self, item.should_display)
      end

      def nav_classes(item)
        current?(item) ? "active" : nil
      end

      def menu_item_label(item)
        helpers.render_in_context(self, item.label)
      end

      def menu_item_url(item)
        helpers.render_in_context(self, item.url)
      end

      def current?(item)
        request.fullpath.start_with?(url_for(menu_item_url(item)))
      end
    end
  end
end
