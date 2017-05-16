class CartItemsController < ApplicationController


  def update
    @cartItem = CartItem.find(params[:id])
    @product = Product.find(@cartItem.product_id)
    if cart_item_params[:quantity].to_i > @product.quantity
      flash[:alert] = "数量不足以加入购物车"
    else
      if !@cartItem.update(cart_item_params)
        flash[:alert] = "变更数量失败"
      else
        flash[:notice] = "变更数量成功"
      end
    end
    redirect_to :back
  end

  def destroy
    @cartItem = CartItem.find(params[:id])
    @product = @cartItem.product
    @cartItem.destroy
    flash[:warning] = "成功将#{@product.title}删除"
    redirect_to :back
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
