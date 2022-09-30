class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :AuthorId, null: false, index: true, foreign_key: {to_table: :users}
      t.references :PostId, null: false, index: true, foreign_key: {to_table: :posts}
      t.text :Text
      t.datetime :UpdatedAt
      t.datetime :CreatedAt
    end
  end
end
