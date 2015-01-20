class UnreadsController < ApplicationController
  before_action :set_unread, only: [:show, :edit, :update, :destroy]

  # GET /unreads
  # GET /unreads.json
  def index
    @unreads = Unread.all
  end

  # GET /unreads/1
  # GET /unreads/1.json
  def show
  end

  # GET /unreads/new
  def new
    @unread = Unread.new
  end

  # GET /unreads/1/edit
  def edit
  end

  # POST /unreads
  # POST /unreads.json
  def create
    @unread = Unread.new(unread_params)

    respond_to do |format|
      if @unread.save
        format.html { redirect_to @unread, notice: 'Unread was successfully created.' }
        format.json { render :show, status: :created, location: @unread }
      else
        format.html { render :new }
        format.json { render json: @unread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unreads/1
  # PATCH/PUT /unreads/1.json
  def update
    respond_to do |format|
      if @unread.update(unread_params)
        format.html { redirect_to @unread, notice: 'Unread was successfully updated.' }
        format.json { render :show, status: :ok, location: @unread }
      else
        format.html { render :edit }
        format.json { render json: @unread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unreads/1
  # DELETE /unreads/1.json
  def destroy
    @unread.destroy
    respond_to do |format|
      format.html { redirect_to unreads_url, notice: 'Unread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unread
      @unread = Unread.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unread_params
      params.require(:unread).permit(:user_id, :article_id)
    end
end
