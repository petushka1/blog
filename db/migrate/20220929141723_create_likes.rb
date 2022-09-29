class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :AuthorId, null: false, index: true, foreign_key: {to_table: :users}
      t.references :PostId, null: false, index: true, foreign_key: {to_table: :posts}
      t.datetime :CreatedAt
      t.datetime :UpdatedAt
    end
  end
end