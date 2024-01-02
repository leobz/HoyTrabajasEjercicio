class ChartsController < ApplicationController

  def providers_resgistration_per_month
    render json: Provider.group_by_month(:created_at).count
  end

  def providers_per_bank
    # TODO: Improve query efficiency
    render json: Provider.group(:bank_id).count.map { |k,v| [Bank.find(k).name, v] }.to_h 
  end
end