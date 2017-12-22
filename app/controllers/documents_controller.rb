class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = smart_listing_create(:documents, scope, partial: 'documents/listing', default_sort: {name: :asc})
    @document = Document.new
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.json { render json: {document: @document, redirect_url: edit_document_path(@document)}, status: :created }
        format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully created.' }
      else
        #format.js
        format.json { render json: @document.errors.messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
  helper_method :people

  def people
    @people ||= Person.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    def scope
      params[:filter].blank? ? Document.all : Document.like(params[:filter])
    end

    def trusted_parameters
      [:name, :researcher, :conducted_at, :location, :notes, :description, :type, person_ids: []]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(*trusted_parameters)
    end

end
