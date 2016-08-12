class DocumentsController < ApplicationController
  before_action :set_order, only: [:pdf]

  def index

  end

  def pdf
    kind = params[:kind]
    render pdf: "#{@order.deceased.name.upcase}_#{kind}",
           template: "documents/#{kind}",
           header: { html: {template: 'documents/_header'} },
           footer: { html: {template: 'documents/_footer'}, spaing: 10 },
           margin: { :top => 10 }
  end

  private
  def set_order
    @order=Order.full.find(params[:id])
  end
end
