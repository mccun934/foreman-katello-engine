class AddKatelloPtables < ActiveRecord::Migration
  def up
    Ptable.create :name => "Katello Fedora Default", :layout =>"zerombr\nclearpart --all --initlabel\npart /boot --fstype ext3 --size=100 --asprimary\npart /     --fstype ext3 --size=1024 --grow\npart swap  --recommended"
  end

  def down
    Ptable.where(:name => "Katello Fedora Default").first.try(:destroy)
  end
end
