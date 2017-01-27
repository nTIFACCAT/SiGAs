class CreateDirectionRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :direction_roles do |t|
      t.references :associate, null: false
      t.string :role, null: false
      t.string :biennium, null: false
      t.timestamps
    end
  end
end
