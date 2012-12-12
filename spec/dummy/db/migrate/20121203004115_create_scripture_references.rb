class CreateScriptureReferences < ActiveRecord::Migration
  def self.up
    create_table :scripture_references do |t|
      t.references :scripturable, :polymorphic => true
      t.integer :scripturable_id
      t.string :starting_verse
      t.timestamps
    end

    add_index :scripture_references, :scripturable_type
    add_index :scripture_references, :scripturable_id
  end

  def self.down
    drop_table :scripture_references
  end
end

