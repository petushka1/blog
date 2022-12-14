class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, null: false, index: true, foreign_key: {to_table: :users}
      t.references :post, null: false, index: true, foreign_key: {to_table: :posts}
      t.text :text
      t.datetime :updated_at
      t.datetime :created_at
    end
  end
end
