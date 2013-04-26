require 'foreman'
require 'foreman/renderer'

module ::Foreman::Renderer
  def unattended_render template
    allowed_helpers   = [ :foreman_url, :katello_url, :katello_host, :katello_port, :subscription_manager_configuration_url, :grub_pass, :snippet, :snippets, :ks_console, :root_pass, :multiboot, :jumpstart_path, :install_path,
                          :miniroot, :media_path]
    allowed_variables = ({:arch => @arch, :host => @host, :osver => @osver, :mediapath => @mediapath, :static => @static,
                         :yumrepo => @yumrepo, :dynamic => @dynamic, :epel => @epel, :kernel => @kernel, :initrd => @initrd,
                         :preseed_server => @preseed_server, :preseed_path => @preseed_path })
    render_safe template, allowed_helpers, allowed_variables
  end
end
