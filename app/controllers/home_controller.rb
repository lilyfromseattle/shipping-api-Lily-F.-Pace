class HomeController < ApplicationController

  def index
    # @locations = ActiveMerchant::Shipping::Location.all
    # @packages = ActiveMerchant::Shipping::Package.all
    # render json: @pets.as_json(only: [:id, :name, :age, :human])
  end

  def ups
    packages = ActiveMerchant::Shipping::Location.new(params[:weight, :dimensions, :cylinder])
    origin = ActiveMerchant::Shipping::Package.new("US", "WA", "Seattle", "98112")
    destination = ActiveMerchant::Shipping::Package.new(params[:country, :state, :city, :zip])
    ups = ActiveMerchant::Shipping::UPS.new(params[:login, :password, :key])
    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render json: @ups_rates.as_json
    # render json: @usps_rates.as_json
  end

  def usps
    packages = ActiveMerchant::Shipping::Location.new(params[:weight, :dimensions, :cylinder])
    origin = ActiveMerchant::Shipping::Package.new("US", "WA", "Seattle", "98112")
    destination = ActiveMerchant::Shipping::Package.new(params[:country, :state, :city, :zip])
    ups = ActiveMerchant::Shipping::USPS.new(params[:login])
    response = ups.find_rates(origin, destination, packages)
    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render json: @usps_rates.as_json
  end

end
