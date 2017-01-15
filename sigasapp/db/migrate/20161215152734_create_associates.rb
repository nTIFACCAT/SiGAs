class CreateAssociates < ActiveRecord::Migration[5.0]
  def change
    create_table :associates do |t|
      t.string :registration, null: false
      t.string :name, null: false
      t.string :gender, null: false
      t.date   :birthdate, null: false
      t.attachment :photo
      t.string :cpf, null: false
      t.string :rg, null: false
      t.string :address, null: false
      t.string :district, null: false
      t.string :city, null: false
      t.string :cep, null: false
      t.string :phone, null: false
      t.string :optional_phone
      t.string :email
      t.references :category, null: false
      t.date   :adminission_date, null:false
      t.boolean :active, null: false, default: true
      t.string :obs
      t.timestamps
    end
  end
end
