class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id, :null => false

      t.string :title, :null => false
      t.text :teaser, :null => false
      t.text :body, :null => false
      t.string :version
      t.text :changelog

     
      t.text :freezebody  # On acceptance of an article, the body is copied in this field
      t.integer :state, :null => false, :default => 0  # 0...draft, 1...submitted, 2...rejected, 3...full article, 4...featured article
      t.string :message  # message to author on reject
      t.date :submitted
      t.date :accepted

      t.timestamps
    end

    add_index :articles, :user_id
  end
end
