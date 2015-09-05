class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.string :task
      t.integer :odds
      t.integer :like_count

      t.timestamps null: false
    end
    add_index :posts, :winner_id
    add_index :posts, :loser_id
  end
end
