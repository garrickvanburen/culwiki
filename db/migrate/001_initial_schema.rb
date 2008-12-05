# SQLEditor export Rails Migration Plugin
# Note that columns named id may have been automatically removed from this file
class InitialSchema < ActiveRecord::Migration
  def self.up

    create_table :people do |t|
      t.column :name, :string
    end
    create_table :pages do |t|
      t.column :title, :string, :limit => 255
      t.column :is_visible, :integer, :default => 1
    end
    create_table :revisions do |t|
      t.column :created_on, :datetime
      t.column :created_by, :integer
      t.column :contents, :text
      t.column :page_id, :integer
      t.column :is_live, :integer, :default => 0
    end
  end

  def self.down
    drop_table :people
    drop_table :pages
    drop_table :revisions
  end
end
