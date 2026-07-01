class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
