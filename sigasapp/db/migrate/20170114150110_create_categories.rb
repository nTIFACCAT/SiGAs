class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :description, null: false
      t.float :value_in_cash, null: false
      t.float :value_in_installments, null: false
      t.timestamps
    end
  end
end
