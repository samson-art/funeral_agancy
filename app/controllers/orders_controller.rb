require 'docx'

class OrdersController < ApplicationController

  TEMPLATES = [
      {
          kind: :service_list, file:'service_list.docx'
      }, {
          kind: :flowers, file: 'flowers.docx'
      }, {
          kind: :check_list, file: 'check_list.docx'
      }]

  before_action :set_order, only: [:show, :edit, :update, :destroy, :download, :docs_generate]

  add_breadcrumb I18n.t('breadcrumbs.orders.homepage'), :orders_path

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.full
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    add_breadcrumb I18n.t('breadcrumbs.orders.show') + @order.id.to_s, order_path(@order)

  end

  # GET /orders/new
  def new
    add_breadcrumb I18n.t('breadcrumbs.orders.new'), '#'
    @order = Order.new
    @order.build_deceased
    @order.build_relative
    @order.flowers.build
  end

  # GET /orders/1/edit
  def edit
    add_breadcrumb I18n.t('breadcrumbs.orders.edit') + @order.id.to_s, edit_order_path(@order)
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
      if @order.relative.update(order_params[:relative_attributes]) and @order.deceased.update!(order_params[:deceased_attributes])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
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

  def download
    send_file("#{Rails.root}/public#{File.dirname(@order.documents.full.first.attach.url)}/#{File.basename(@order.documents.full.first.attach.url, '?*')}", :x_sendfile => true, :disposition => 'attachment', :filename => "order_#{@order.id}_service_list.docx", :type => :docx)
  end

  def docs_generate
    _docs_gen
    redirect_to @order, flash: {success: 'Documents generated'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.full.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:deceased_attributes => [:name, :birthday, :deathday, :funeral_day, :funeral_place, :crematorium_kind, :photo, :cemetery_name, :funeral_time, :coffin_kind, :flowerday, :flowertime, :coffin_prepare_by, :coffin_issued_by, :note], :relative_attributes => [:name, :phone, :mobile, :relationship], :flowers_attributes => [:kind, :text, :price])
    end

    def set_template
      {
        'name' => @order.deceased.name,
        'birthday' => @order.deceased.birthday,
        'deathday' => @order.deceased.deathday,
        'funeralplace' => @order.deceased.funeral_place,
        'funeralday' => @order.deceased.funeral_day,
        'funeraltime' => @order.deceased.funeral_time,
        'cemeteryname' => @order.deceased.cemetery_name,
        'vistday' => '',
        'morgue' => '',
        'relativename' => @order.relative.name,
        'relativephone' => @order.relative.phone,
        'relativemobile' => @order.relative.mobile,
        'relationship' => @order.relative.relationship,
        'note' => @order.deceased.note,
        'coffinissuedby' => @order.deceased.coffin_issued_by,
        'crematoriumkind' => @order.deceased.crematorium_kind,
        'coffinprepareby' => @order.deceased.coffin_prepare_by,
        'coffinkind' => @order.deceased.coffin_kind,
        'flowerday' => @order.deceased.flowerday,
        'flowertime' => @order.deceased.flowertime
      }

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
