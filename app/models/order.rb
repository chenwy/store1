# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  total            :integer          default("0")
#  user_id          :integer
#  billing_name     :string
#  billing_address  :string
#  shipping_name    :string
#  shipping_address :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Order < ApplicationRecord

  before_create :generate_token

  belongs_to :user
  has_many :product_lists

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  def pay!
    self.update_columns(is_paid: true)
  end

  include AASM

  aasm do
    state :order_placed, initial: true  #已下订
    state :paid                         #已付款
    state :shipping                     #出货中
    state :shipped                      #到货
    state :order_cancelled              #取消订单
    state :good_returned                #退货

    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :shipping do
      transitions from: :paid, to: :shipping
    end

    event :ship do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

end
