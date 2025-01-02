class OrdersController < ApplicationController
  def new
    @order = Order.new # Orderクラスの新しいインスタンスを作成
    @order.order_products.build # order_productsの新しいインスタンスを作成
  end

  def confirm
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成

    return render :new if @order.invalid? # バリデーションエラーがある場合、newアクションを再度実行
  end

  def create
    @order = Order.new(order_params) # order_paramsから受け取った値を使ってOrderクラスの新しいインスタンスを作成。戻るボタンを押した場合でも、入力した値を保持する
    return render :new if params[:button] == 'back' # ボタンが「戻る」の場合、newアクションを再度実行

    if @order.save # 保存に成功した場合、completeアクションにリダイレクト
      session[:order_id] = @order.id
      return redirect_to complete_orders_url
    end

    render :confirm # 保存に失敗した場合、newアクションを再度実行
  end

  def complete
    @order = Order.find_by(id: session[:order_id]) # session[:order_id]からOrderクラスのインスタンスを取得
    return redirect_to new_order_url if @order.blank? # インスタンスがnilの場合、newアクションにリダイレクト

    session[:order_id] = nil # session[:order_id]をnilにする
  end

  private # クラス内でのみ使用可能、この下に書かれたメソッドは、外部から呼び出せないようにする

  def order_params
    params
      .require(:order)
      .permit(:name,
              :email,
              :telephone,
              :delivery_address,
              :payment_method_id,
              :other_comment,
              :direct_mail_enabled,
              inflow_source_ids: [],
              order_products_attributes: %i[product_id quantity]) # permitを使うことで、指定したパラメータ以外を受け付けないようにしている
  end
end
