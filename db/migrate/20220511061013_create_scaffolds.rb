class CreateScaffolds < ActiveRecord::Migration[7.0]
  def change
    create_table :scaffolds do |t|

      t.timestamps
    end
  end
end
