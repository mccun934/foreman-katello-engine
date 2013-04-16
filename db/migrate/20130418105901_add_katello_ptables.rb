class AddKatelloPtables < ActiveRecord::Migration
  def up
    Ptable.create :name => "Fedora default", :layout =>"zerombr\nclearpart --all --initlabel\npart /boot --fstype ext3 --size=100 --asprimary\npart /     --fstype ext3 --size=1024 --grow\npart swap  --recommended"
  end

  def down
  end
end
