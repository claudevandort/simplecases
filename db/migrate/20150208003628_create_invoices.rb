class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :description
      t.integer :amount
      t.references :subscription

      t.timestamps
    end
  end
end
