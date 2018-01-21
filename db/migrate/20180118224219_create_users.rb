class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :age
      t.string :bio
    end

    add_index :users, :username, unique: true
  end
end
