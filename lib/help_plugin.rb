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
      def execute
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
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..", "views", name)))
        rhtml.result(binding)
      end
      
      def index
        puts "INDEX"
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..", "views", "index.html.erb")))
        name = "users-guide-bundles"
        rhtml.result(binding)
      end
      
      def forward
        cgi = CGI.new
        name = cgi["name"]
        id = cgi["id"]
        if name.nil? 
          puts "No content name specified, defaulting to users-guide-bundles"
          name = "users-guide-bundles"
        end
        puts "Forwarding to #{name}"
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..", "views", "index.html.erb")))
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
          item "View User Manual (Online)", Help::ViewUserManualOnlineCommand
        end
      end
      #end
    end

    
  end
end
