class CreateNodeGroups < ActiveRecord::Migration
  def change
    create_table :node_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
