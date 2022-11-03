class OrdersController < ApplicationController
  before_action :authenticate_user!


  def index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    @order_customer = OrderCustomer.new
  end

  def create
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    @order_customer = OrderCustomer.new(order_params)
    if @order_customer.valid?
      @order_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_customer).permit(:zipcode, :prefecture_id, :city, :address_line, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
