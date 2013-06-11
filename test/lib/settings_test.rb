require 'test_helper'

class SettingsTest < ActiveSupport::TestCase

  def setup
    Setting::Katello.all.each(&:destroy)
  end

  test "katello specific settings" do
    Setting::Katello.load_defaults
    assert_equal 'https://localhost/katello', Setting::Katello['katello_url']
  end

end
