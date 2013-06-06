class Setting::Katello < ::Setting

  def self.load_defaults
    return unless (self.table_exists? rescue false)
    BLANK_ATTRS << "katello_url"
    Setting.transaction do
      [
       self.set('katello_url', 'url of a Katello instance', 'https://localhost/katello'),
      ].compact.each { |s| self.create! s.update(:category => "Setting::Katello")}
    end
    true
  end

end
