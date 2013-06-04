Deface::Override.new(:virtual_path => "spree/home/index",
                     :name => "sidebar",
                     :insert_after => "[data-hook='homepage_sidebar_navigation']",
                     :text => "<%= render_snippet('home-side-info') %>",
                     :disabled => false)

