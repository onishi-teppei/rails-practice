class OrdersController < ApplicationController
  def new
    @order = Order.new # Orderクラスの新しいインスタンスを作成
  end

  def confirm
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成
  end

  def create
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成。戻るボタンを押した場合でも、入力した値を保持する
    return render :new if params[:button] == 'back' # ボタンが「戻る」の場合、newアクションを再度実行
    return redirect_to complete_orders_url if @order.save # 保存に成功した場合、completeアクションにリダイレクト

    render :confirm # 保存に失敗した場合、newアクションを再度実行
  end

  private # クラス内でのみ使用可能、この下に書かれたメソッドは、外部から呼び出せないようにする

  def order_params
    params
      .require(:order)
      .permit(:name,
              :email,
              :telephone,
              :delivery_address) # permitを使うことで、指定したパラメータ以外を受け付けないようにしている
  end
end