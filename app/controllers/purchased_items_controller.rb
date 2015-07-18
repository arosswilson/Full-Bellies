class PurchasedItemsController < ApplicationController
  def new
    @deal = Deal.find(params[:deal_id])
    @purchased_item = PurchasedItem.new
  end

  def create

    deal = Deal.find(params[:deal_id])
    if purchase_quantity_less_than_deal_quantity?(params[:quantity], deal) && is_current?(deal)
      update_deal_quantity(params[:quantity],deal)
      purchased_item = PurchasedItem.create(purchased_item_params)
      purchased_item.update_attributes(price: calculate_price(params[:quantity], deal), user_id: current_user.id)



      customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => calculate_stripe_amount(params[:quantity], deal),
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "There was an error with your purchase. Please check the exiration time and quantity to make sure you're making a valid purchase"
      redirect_to :back
    end
  end

  private

  def purchased_item_params
    params.permit(:deal_id, :title,:description,:quantity)
  end

  def calculate_price(quantity, deal)
    return quantity.to_i * deal.item_price.to_f
  end

  def current_user
    return User.find(session[:user_id]) if !!session[:user_id]
  end

  def calculate_stripe_amount(quantity, deal)
    (calculate_price(quantity, deal) * 100).to_i
  end

  def purchase_quantity_less_than_deal_quantity?(quantity, deal)
    quantity.to_i <= deal.item_quantity && quantity.to_i > 0
  end

  def update_deal_quantity(quantity, deal)
    deal.update_attributes(item_quantity: (deal.item_quantity - quantity.to_i) )
  end

  def is_current?(deal)
    binding.pry
    deal.end_time.getlocal > Time.now
  end


end
