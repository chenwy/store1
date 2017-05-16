class CartItemsController < ApplicationController


  def update
    @cartItem = CartItem.find(params[:id])
    @product = Product.find(@cartItem.product_id)
    q = cart_item_params[:quantity]
    if q.to_i > @product.quantity
      flash[:alert] = "更新数量超过了库存"
    else
      if !@cartItem.update(cart_item_params)
        flash[:alert] = "更新错误"
      else
        flash[:notice] = "更新成功"
      end
    end
    redirect_to :back
  end

  def destroy
    @cartItem = CartItem.find(params[:id])
    @cartItem.destroy
    redirect_to :back
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
