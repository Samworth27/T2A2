class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :originator, null: false, foreign_key: { to_table: 'users' }
      t.references :recipient, null: false, foreign_key: { to_table: 'users' }
      t.text :message

      t.timestamps
    end
  end
end
