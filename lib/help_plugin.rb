require 'erb'
require 'cgi'

module Redcar
  class Help
    class ViewUserManualCommand < Redcar::Command
      def execute
        controller = Controller.new
        tab = win.new_tab(HtmlTab)
        tab.html_view.controller = controller
        tab.focus
      end
    end

    class ViewUserManualOnlineCommand < Redcar::Command
      def execute   # Should forward to: http://wiki.github.com/danlucraft/redcar/users-guide
        controller = Controller.new
        tab = win.new_tab(HtmlTab)
        tab.html_view.controller = controller
        tab.focus
      end
    end

    class Controller
      def title
        "Help"
      end
      
      def render(name, id=nil)
        base_path = File.join(File.dirname(__FILE__), "..", "views")
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..", "views", name)))
        rhtml.result(binding)
      end
      
      def index
        forward({"name" => "users-guide-getting-started", "id" => "10"})
      end
      
      def forward(params)
        base_path = File.join(File.dirname(__FILE__), "..", "views")
        name = params["name"]
        id = params[:id]
        if name.nil? or name.length < 1
          puts "No content name specified, defaulting to users-guide-bundles"
          name = "users-guide-getting-started"
        end
        puts "Forwarding to #{name}"
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..", "views", "template.html.erb")))
        rhtml.result(binding)
      end
    end
    
    # This method is run as Redcar is booting up.
    def self.menus
      # Here's how the plugin menus are drawn. Try adding more
      # items or sub_menus.
      Menu::Builder.build do
        #sub_menu "Plugins" do
        sub_menu "Help" do
          item "View User Manual", Help::ViewUserManualCommand
          #item "View User Manual (Online)", Help::ViewUserManualOnlineCommand
        end
      end
      #end
    end

    
  end
end
