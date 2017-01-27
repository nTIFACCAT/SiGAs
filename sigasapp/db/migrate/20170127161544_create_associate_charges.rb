class CreateAssociateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :associate_charges do |t|
      t.string :description, null: false
      t.references :associate, null: false
      t.float :value, null: false
      t.date :due_date, null: false
      t.date :pay_date
      t.float :additions
      t.float :discounts
      t.string :payment_form
      t.string :obs
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
