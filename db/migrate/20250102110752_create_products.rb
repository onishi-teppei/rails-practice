class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, comment: '商品マスタ' do |t|
      t.string :name, null: false, comment: '商品名称'
      t.integer :price, null: false, comment: '価格'

      t.timestamps
    end
  end
end
