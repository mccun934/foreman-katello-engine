class AddKatelloTemplates < ActiveRecord::Migration
  def self.up
    ConfigTemplate.where(:name => "Katello Kickstart Default").first_or_create!( 
        :template_kind_id    => TemplateKind.find_by_name('provision').id,
        :operatingsystem_ids => Redhat.all.map(&:id),
        :template            => File.read("#{ForemanKatelloEngine::Engine.root}/app/views/unattended/kickstart-katello.erb"))
    
    ConfigTemplate.where(:name => "subscription_manager_registration").first_or_create!(
      :snippet  => true,
      :template => File.read("#{ForemanKatelloEngine::Engine.root}/app/views/unattended/snippets/_subscription_manager_registration.erb"))
  rescue Exception => e
    # something bad happened, but we don't want to break the migration process
    Rails.logger.warn "Failed to migrate #{e}"
    return true
  end

  def self.down
  end
end
