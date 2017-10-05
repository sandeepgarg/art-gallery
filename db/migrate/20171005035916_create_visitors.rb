class CreateVisitors < ActiveRecord::Migration[5.1]
  def change
    create_table :visitors do |t|
      t.integer :visitor_id
      t.integer :room_visits
      t.integer :average_stay
      t.belongs_to :log_file, index: true
      t.timestamps
    end
  end
end
