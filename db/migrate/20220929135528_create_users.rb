class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :posts_counter, default: 0
    end
  end
end