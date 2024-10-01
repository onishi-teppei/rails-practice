class AddReferencePaymentMethodIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :payment_method, foreign_key: { on_update: :restrict, on_delete: :restrict }, comment: '支払い情報'
  end
end
