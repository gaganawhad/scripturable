class CreateScriptureReferences < ActiveRecord::Migration
  def self.up
    create_table :scripture_references do |t|
      t.references :scripturable, :polymorphic => true
      t.integer :scripturable_id
      t.integer :start_at
      t.integer :end_at
      t.timestamps
    end

    add_index :scripture_references, :scripturable_type
    add_index :scripture_references, :scripturable_id
  end

  def self.down
    drop_table :scripture_references
  end
end

