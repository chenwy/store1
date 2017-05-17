class OrderMailer < ApplicationMailer

  def notify_order_placed(order)
    @order = order
    @user = order.user
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[JDstore]感谢您完成本次的下单，以下是您这次购物明细 #{order.token}")
  end

  def notify_cancel_order(order)
    @order = order
    @user = order.user 
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[JDstore]该订单已被用户取消， 以下是明细#{order.token}")
  end

  def notify_order_shipping(order)
    @order = order
    @user = order.user
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[JDstore]该订单#{order.id}已发货， 以下是明细#{order.token}")
  end

  def notify_admin_cancel_order(order)
    @order = order
    @user = order.user #应该通知admin
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[JDstore]该订单已被用户取消， 以下是明细#{order.token}")
  end

end
