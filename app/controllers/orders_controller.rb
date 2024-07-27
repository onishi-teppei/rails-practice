class OrdersController < ApplicationController
  def new
    @order = Order.new # Orderクラスの新しいインスタンスを作成
  end

  def confirm
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成
  end

  def create
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成
    @order.save # データベースに保存
  end

  private # クラス内でのみ使用可能、この下に書かれたメソッドは、外部から呼び出せないようにする

  def order_params
    params.require(:order).permit(:name) # permitを使うことで、指定したパラメータ以外を受け付けないようにしている
  end
end