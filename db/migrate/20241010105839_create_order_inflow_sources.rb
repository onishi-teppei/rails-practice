class CreateOrderInflowSources < ActiveRecord::Migration[7.0]
  def change
    create_table :order_inflow_sources, comment: '注文情報 ユーザーが選択した流入元' do |t|
      t.references :order, null: false, index: true, foreign_key: { on_delete: :cascade, on_update: :cascade }, comment: '注文情報'
      t.references :inflow_source, null: false, index: true, foreign_key: { on_delete: :restrict, on_update: :restrict }, comment: '注入元マスタ'

      t.timestamps
    end
  end
end
