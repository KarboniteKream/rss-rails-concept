class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.binary :icon

      t.timestamps null: false
    end
  end
end
