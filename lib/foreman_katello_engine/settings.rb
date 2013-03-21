module ForemanKatelloEngine
  class Settings

    def self.initialize_settings
      # proceed only if db set up correctly
      Setting.first rescue return
      [
       Foreman::DefaultSettings::Loader.set('katello_url', 'url of a Katello instance', 'https://localhost/katello')
      ].each { |s| Foreman::DefaultSettings::Loader.create(s.update(:category => "General")) }
    end

  end
end
