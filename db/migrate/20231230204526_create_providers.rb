class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :nit
      t.string :name
      t.string :contact_name
      t.string :contact_phone
      t.integer :bank_id
      t.string :account_number

      t.timestamps
    end
  end
end
