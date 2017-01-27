class CreateAssociateBonds < ActiveRecord::Migration[5.0]
  def change
    create_table :associate_bonds do |t|
      t.references :associate, null: false
      t.string :bond, null: false
      t.references :dependent, null: false
      t.timestamps
    end
  end
end
