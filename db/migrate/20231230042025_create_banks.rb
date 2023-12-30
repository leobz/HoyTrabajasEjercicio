class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks, id: false, primary_key: :name do |t|
      t.string :name
    end
  end
end
