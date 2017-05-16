class CartsController < ApplicationController

  def clear
    current_cart.clear!
    redirect_to carts_path
  end
end
