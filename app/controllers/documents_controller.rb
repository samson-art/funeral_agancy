class DocumentsController < ApplicationController
  before_action :set_order, only: [:pdf]

  def index

  end

  def pdf
    kind = params[:kind]
    render pdf: "#{@order.deceased.name.upcase}_#{kind}", template: "documents/#{kind}"
  end

  private
  def set_order
    @order=Order.full.find(params[:id])
  end
end
