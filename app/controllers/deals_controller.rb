class DealsController < ApplicationController
  before_action :require_vendor_login, except: [:index, :show]

  def index
    @deals = Deal.where("end_time > ? AND item_quantity > ?", Time.now, 0).order(created_at: :desc)
    @user = User.new
    @vendor = Vendor.new
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.update_attributes(vendor_id: current_vendor.id, end_time: deal_time)
    @vendor = current_vendor
    if @deal.save
      @vendor.send_followers_sms(@deal)
      # UserMailer.email_followers(@deal).deliver <= SG NOT DELIVERING
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
    deal = Deal.find(params[:id])
    deal.update_attributes(deal_params)
    deal.update_attributes(end_time: deal_time)
    redirect_to current_vendor
  end

  def show
    @deal = Deal.find(params[:id])
    @user = User.new
    @vendor = Vendor.new
  end

  def destroy
    deal = Deal.find(params[:id])
    deal.destroy
    redirect_to current_vendor
  end

  private

    def deal_params
      params.require(:deal).permit(:title, :description, :item_quantity, :item_price)
    end

    def deal_time
      Time.local(params[:deal]["end_time(1i)"].to_i, params[:deal]["end_time(2i)"].to_i, params[:deal]["end_time(3i)"].to_i, params[:deal]["end_time(4i)"].to_i, params[:deal]["end_time(5i)"].to_i)
    end

    def current_vendor
      return Vendor.find(session[:vendor_id])
    end

end
