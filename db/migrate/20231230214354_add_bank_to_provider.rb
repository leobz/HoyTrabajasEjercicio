class AddBankToProvider < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :providers, :banks
  end
end
