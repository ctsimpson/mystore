Deface::Override.new(:virtual_path => "spree/shared/_footer",
                     :name => "replace_spree",
                     :replace => "div#footer-left p",
                     :text => "Copyright mystore.com",
                     :disabled => false)
