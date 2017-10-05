class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.belongs_to :room, index: true
      t.belongs_to :visitor, index: true
      t.integer :stay
      t.timestamps

    end
  end
end
