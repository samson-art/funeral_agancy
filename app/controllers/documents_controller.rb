class DocumentsController < ApplicationController
  before_action :set_order, only: [:pdf]

  def index

  end


  def check_list
    pdf(:check_list, { html: {template: 'documents/_header'} }, { html: {template: 'documents/_footer'}, spaing: 10 })
  end

  def service_list
    pdf(:service_list, { html: {template: 'documents/_header'} }, { html: {template: 'documents/_footer'}, spaing: 10 })
  end

  def flowers
    pdf(:flowers, { html: {template: 'documents/_header'} })
  end

  def cremazione
    pdf(:cremazione)
  end

  def epigrafe
    pdf(:epigrafe)
  end

  private

    def set_order
      @order=Order.full.find(params[:id])
    end

    def pdf(kind, header=nil, footer=nil)
      set_order
      render pdf: "#{@order.deceased.name.upcase}_#{kind}",
             template: "documents/#{kind}",
             header: header,
             footer: footer,
             margin: { :top => 10 }
    end

end
