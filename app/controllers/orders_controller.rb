require 'gon'

class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @order_by = params[:order]
    @query = params[:query]
    @orders =  Order.search(@query)
    if params[:archived]
      @orders = @orders.archived
    else
      @orders = @orders.active
    end
    if @order_by.present?
      if @order_by == 'relative'
        @orders = @orders.ordered_relative
      elsif @order_by == 'name'
        @orders = @orders.ordered_name
      elsif @order_by == 'updated'
        @orders = @orders.ordered
      end
    end
    @reverse = params[:reverse]
    if @reverse.present?
      @orders = @orders.reverse_order
    end
    @page = params[:page] || 1
    @orders = @orders.paginate(:page => @page || 1, :per_page => 8)
    view = params[:view]
    if view.present?
      @view = view
    else
      @view = 'card'
    end



    respond_to do |format|
      format.html
      format.json
      format.js
    end

  end

  # GET /orders/1
  # GET /orders/1.json
  def show

  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.build_deceased
    @order.build_relative
    @order.flowers.build
    @order.assistants.build
    @order.cars.build
    @funeral_places = Hash[Deceased.funeral_places.map{|x| [x, nil]}]
    gon.funeral_places = @funeral_places
    @cemetery_names = Hash[Deceased.cemetery_names.map{|x| [x, nil]}]
    gon.cemetery_names = @cemetery_names
    @relationships = Hash[Relative.relationships.map{|x| [x, nil]}]
    gon.relationships = @relationships
    @coffin_kinds = Hash[Deceased.coffin_kinds.map{|x| [x, nil]}]
    gon.coffin_kinds = @coffin_kinds
  end

  # GET /orders/1/edit
  def edit
    @funeral_places = Hash[Deceased.funeral_places.map{|x| [x, nil]}]
    gon.funeral_places = @funeral_places
    @cemetery_names = Hash[Deceased.cemetery_names.map{|x| [x, nil]}]
    gon.cemetery_names = @cemetery_names
    @relationships = Hash[Relative.relationships.map{|x| [x, nil]}]
    gon.relationships = @relationships
    @coffin_kinds = Hash[Deceased.coffin_kinds.map{|x| [x, nil]}]
    gon.coffin_kinds = @coffin_kinds
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
        format.js { render 'orders/show/note', locals: { msg: 'Success update!', key: 'success' } }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js { render 'orders/show/note', locals: { msg: 'Something goes wrong!', key: 'error' } }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def archivate
    @order = Order.part.find(params[:order_id])
    @order.status = :archived
    if @order.save!
      redirect_to @order, notice: 'Order was successfully archived.'
    else
      render :json => false
    end

  end

  def activate
    @order = Order.part.find(params[:order_id])
    @order.status = :active
    if @order.save!
      redirect_to @order, notice: 'Order was successfully activated.'
    else
      render :json => false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.full.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:id, :status, :deceased_attributes => [:firstname, :lastname, :birthday, :deathday, :funeral_day, :funeral_place, :crematorium_kind, :photo, :cemetery_name, :funeral_time, :coffin_kind, :flowerday, :flowertime, :coffin_prepare_by, :coffin_issued_by, :note, :exposure_day, :morgue_work_from, :morgue_work_to, :departure_day, :departure_time, :pillow_take, :instruments_1, :instruments_2, :instruments_3], :relative_attributes => [:firstname, :lastname, :phone, :mobile, :relationship], :flowers_attributes => [:id, :kind, :text, :price, :_destroy], :assistants_attributes => [:id, :name, :_destroy], :cars_attributes => [:id, :model, :_destroy])
    end

    def _docs_gen
      fields = set_template
      TEMPLATES.each do |template|
        tmp_file = Tempfile.new("#{template[:kind]}", "#{Rails.root}/tmp")
        tmp_file.close
        new_name = "#{File.dirname(tmp_file)}/#{@order.deceased.name}_#{template[:kind]}.docx".upcase
        File.rename(tmp_file, new_name)
        d = Document.find_or_create_by(order: @order, kind: Document.kinds[template[:kind]])
        doc = Docx::Document.open("#{Rails.root}/lib/docx_templates/#{template[:file]}")
        doc.bookmarks.each do |bm|
          doc.bookmarks[bm[0]].insert_text_after(fields[bm[0]])
        end
        file = File.open(new_name)
        doc.save(file)
        d.attach = file
        d.save!
        file.close
      end

    end
end
