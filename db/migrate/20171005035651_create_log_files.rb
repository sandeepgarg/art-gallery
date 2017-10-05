class CreateLogFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :log_files do |t|
      t.string :name
      t.string :content_type
      t.timestamps
    end
  end
end
