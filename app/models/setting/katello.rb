class Setting::Katello < ::Setting

  def self.load_defaults
    # if db is not migrated, BLANK_ATTRS are not loaded
    return unless defined? BLANK_ATTRS
    BLANK_ATTRS << "katello_url"
    Setting.transaction do
      [
       self.set('katello_url', 'url of a Katello instance', 'https://localhost/katello'),
      ].compact.each { |s| self.create s.update(:category => "Setting::Katello")}
    end
    true
  end

end
