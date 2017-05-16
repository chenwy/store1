class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if @product.quantity == 0
      flash[:alert] = "已没有库存，请等待进货"
    else
      if current_cart.cart_items.find_by(product_id: @product.id)
        flash[:alert] = "该商品已加入购物车，请勿重复添加"
      else
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "成功加入购物车"
      end
    end
    redirect_to :back
  end
end
