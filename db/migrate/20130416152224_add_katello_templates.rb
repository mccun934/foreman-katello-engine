class AddKatelloTemplates < ActiveRecord::Migration
  def self.up
    ConfigTemplate.create(
      :name                => "Katello Kickstart Default",
      :template_kind_id    => TemplateKind.find_by_name('provision').id,
      :operatingsystem_ids => Redhat.all.map(&:id),
      :template            => File.read("#{ForemanKatelloEngine::Engine.root}/app/views/unattended/kickstart-katello.erb"))
      
    ConfigTemplate.create(
      :name     => "Subscription Manager Registration",
      :snippet  => true,
      :template => File.read("#{ForemanKatelloEngine::Engine.root}/app/views/unattended/snippets/_katello_registrayion.erb"))
  rescue Exception => e
    # something bad happened, but we don't want to break the migration process
    Rails.logger.warn "Failed to migrate #{e}"
    return true
  end

  def self.down
  end
end
