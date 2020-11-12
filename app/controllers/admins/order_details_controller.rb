class Admins::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!
   layout 'admins/header'
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order #注文ステータスを更新するためにordersテーブルを呼び出す
    @order_detail.update(order_detail_params) #製作ステータスを更新
    if @order_detail.making_status == "製作中"
       @order.update(status: "製作中") #製作ステータスが「製作中」なら注文ステータスを「作成中」に更新
    #上記条件に当てはまらない場合、商品個数を特定。製作ステータスが「製作完了」の商品を数える。
    #数が一致すれば、全ての商品の作成ステータスが「製作完了」となる。
    elsif @order.order_details.count == @order.order_details.where(making_status: "製作完了").count
       @order.update(status: "発送準備中") #注文ステータスを「発送準備中」に更新
    end
    redirect_to admins_order_path(@order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
