# This migration comes from flexible_feeds (originally 20140227194904)
class CreateFlexibleFeedsEventJoins < ActiveRecord::Migration
  def change
    create_table :flexible_feeds_event_joins do |t|
      t.integer :feed_id
      t.integer :event_id
      t.boolean :sticky, null: false, default: false

      t.timestamps
    end

    add_index :flexible_feeds_event_joins, :sticky
    add_index :flexible_feeds_event_joins, :feed_id
    add_index :flexible_feeds_event_joins, :event_id
  end
end
