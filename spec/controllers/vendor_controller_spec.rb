require 'rails_helper'

describe VendorsController do
	describe 'vendor access' do
		before :each do
			@vendor = create(:vendor)
			session[:vendor_id] = @vendor.id
		end
	end
end