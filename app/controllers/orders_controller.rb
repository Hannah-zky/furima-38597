class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_customer = OrderCustomer.new
  end

  def create
    @item = Item.find(params[:item_id])
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
