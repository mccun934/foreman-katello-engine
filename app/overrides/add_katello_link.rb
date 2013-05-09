Deface::Override.new(:virtual_path => "home/_topbar",
                     :name => "add_katello_link",
                     :insert_after => 'code[erb-loud]:contains("render"):contains("home/settings")',
                     :partial => 'foreman_katello_engine/layout/katello_link')
