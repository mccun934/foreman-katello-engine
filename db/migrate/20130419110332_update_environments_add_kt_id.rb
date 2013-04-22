class UpdateEnvironmentsAddKtId < ActiveRecord::Migration
  def up
    add_column :environments, :kt_id, :string
  end

  def down
    remote_column :environment, :kt_id
  end
end
