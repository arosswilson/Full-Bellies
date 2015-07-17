class DealsController < ApplicationController

  def index
    @deals = Deal.order(created_at: :desc)
  end

  def new
    @deal = Deal.new

  end

  def create
    deal = Deal.new(deal_params, vendor_id: current_vendor.id)
    if deal.save
      redirect_to current_vendor
    else
      flash[:notice] = "all fields are required."
      redirect_to new_deal_path
    end

  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update

  end

  def show
    @deal = Deal.find(params[:id])
  end

  def destroy

  end

  private

    def deal_params
      params.require(:deal).permit(:title, :description, :item_quantity, :item_price)
    end

    def current_vendor
      return Vendor.find(session[:vendor_id])
    end

end