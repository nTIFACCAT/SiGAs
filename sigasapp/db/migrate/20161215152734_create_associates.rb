class CreateAssociates < ActiveRecord::Migration[5.0]
  def change
    create_table :associates do |t|

      t.timestamps
    end
  end
end
