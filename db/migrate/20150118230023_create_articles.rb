class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :feed_id
      t.string :title
      t.string :url
      t.string :author
      t.datetime :date
      t.text :content

      t.timestamps null: false
    end
  end
end
