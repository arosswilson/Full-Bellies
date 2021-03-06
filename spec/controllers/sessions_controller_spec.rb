require 'rails_helper'

describe SessionsController do
  before(:each) do
    @registered_user = create(:user, username: "bob")
    @registered_vendor = create(:vendor, username: "ross's pizza")
  end

  describe "GET #new" do
    it "allows a user to login" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "allows a vendor to login" do
      get :new
      expect(assigns(:vendor)).to be_a_new(Vendor)
    end
  end

  describe "POST #user_create" do
    it "should login a user with correct credentials" do
      post :user_create, {user: {username: @registered_user.username, password: @registered_user.password}}
      expect(session[:user_id]).to eq(@registered_user.id)
    end

    it "should not login a user with incorrect credentials" do
      post :user_create, {user: {username: "wrong name", password: @registered_user.password}}
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #vendor_create" do
    it "should login a vendor with correct credentials" do
      post :vendor_create, {vendor: {username: @registered_vendor.username, password: @registered_vendor.password}}
      expect(session[:vendor_id]).to eq(@registered_vendor.id)
    end

    it "should not login a vendor with incorrect credentials" do
      post :vendor_create, {vendor: {username: "wrong name", password: @registered_vendor.password}}
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE sessions#destroy" do
    it "should set the session user_id to nil" do
      delete :destroy, id: @registered_user.id
      expect(session[:user_id]).to eq nil
    end

    it "should set the session vendor_id to nil" do
      delete :destroy, id: @registered_vendor.id
      expect(session[:vendor_id]).to eq nil
    end

    it "should redirect to root path if incorrect" do
      delete :destroy, id: @registered_vendor.id
      expect(response).to redirect_to root_path
    end
  end
end
