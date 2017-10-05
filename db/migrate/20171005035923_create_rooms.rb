class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.integer :visitor_count
      t.integer :average_stay
      t.belongs_to :log_file, index: true
      t.timestamps
    end
  end
end
