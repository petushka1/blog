class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :AuthorId, null: false, index: true, foreign_key: {to_table: :users}
      t.string :Title
      t.text :Text
      t.datetime :CreatedAt
      t.datetime :UpdatedAt
      t.integer :CommentsCounter
      t.integer :LikesCounter
    end
  end
end
