module ForemanKatelloEngine
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inhereits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine
    initializer "foreman_katello_engine.load_app_instance_data" do |app|
      app.config.paths['db/migrate'] += ForemanKatelloEngine::Engine.paths['db/migrate'].existent
    end

    config.after_initialize do
      Setting::Katello.load_defaults
      require 'foreman_katello_engine/bindings'
      require 'foreman_katello_engine/renderer'
    end

    initializer 'foreman_katello_engine.helper' do |app|
      ActionView::Base.send :include, ForemanKatelloEngine::HostsAndHostgroupsHelper
      ActionView::Base.send :include, ForemanKatelloEngine::KatelloUrlsHelper
    end
  end
end
