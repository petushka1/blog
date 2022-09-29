class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Photo
      t.text :Bio
      t.datetime :CreatedAt
      t.datetime :UpdatedAt
      t.integer :PostsCounter
    end
  end
end