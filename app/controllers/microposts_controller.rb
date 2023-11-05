class MicropostsController < ApplicationController
  before_action :set_micropost, only: %i[ show edit update destroy ]

  # GET /microposts or /microposts.json
  def index
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
    end
    @microposts = Micropost.all
  end

  # GET /microposts/1 or /microposts/1.json
  def show
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
    end
    @micropost = Micropost.find(params[:id])
    @comment = @micropost.comments
  end

  # GET /microposts/new
  def new
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
    end
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
    end
  end

  # POST /microposts or /microposts.json
  def create
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
      @micropost = @user.microposts.build(micropost_params)

      respond_to do |format|
        if @micropost.save
          format.html { redirect_to user_micropost_url(@user, @micropost), notice: "Micropost was successfully created." }
          format.json { render :show, status: :created, location: @micropost }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @micropost.errors, status: :unprocessable_entity }
        end
      end
    else
      @micropost = Micropost.new(micropost_params)
      respond_to do |format|
        if @micropost.save
          format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully created." }
          format.json { render :show, status: :created, location: @micropost }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @micropost.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        if params.key?(:user_id)
          @user = User.find(params[:user_id])
          format.html { redirect_to user_micropost_url(@user, @micropost), notice: "Micropost was successfully updated." }
        else
          format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully updated." }
        format.json { render :show, status: :ok, location: @micropost }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1 or /microposts/1.json
  def destroy
    @micropost.destroy!

    respond_to do |format|
      format.html { redirect_to microposts_url, notice: "Micropost was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def micropost_params
      params.require(:micropost).permit(:title, :content, :user_id)
    end
end
