class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.boolean :active, null: false, default: true
      t.string :phone
      t.string :role
      t.attachment :photo
      t.datetime :last_sign_in_at
      t.string :last_sign_in_ip
      t.timestamps
    end
  end
end
