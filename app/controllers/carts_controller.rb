class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = @cart
  end

  def add
    id = params[:id].to_s
    @cart[id] ||= 0
    @cart[id] += 1

    save_cart
    redirect_to cart_path, notice: "Item added to cart"
  end

  def remove
    @cart.delete(params[:id].to_s)
    save_cart
    redirect_to cart_path, notice: "Item removed"
  end

  def update
    id = params[:id].to_s
    quantity = params[:quantity].to_i
    @cart[id] = quantity if quantity > 0
    save_cart
    redirect_to cart_path
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= {}
  end

  def save_cart
    session[:cart] = @cart
  end
end
