class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  # rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
    end
    if params.key?(:micropost_id)
      @micropost = Micropost.find(params[:micropost_id])
    end
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    if params.key?(:user_id)
      @user = User.find(params[:user_id])
      @micropost = @user.microposts.find(params[:micropost_id])
    else
      @micropost = Micropost.find(params[:micropost_id])
    end
    @comment = @micropost.comments.build
    # @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    if params[:comment].key?(:user_id)
      puts "TESTING"
      puts params[:comment][:user_id]
      # if the micropost doesn't exist, return an error
      @micropost = Micropost.find(params[:comment][:micropost_id])
      @user = User.find(params[:comment][:user_id])
      # @micropost = @user.microposts.find(params[:comment][:micropost_id])
      @comment = @micropost.comments.build(comment_params)
      # @comment.user = @user
      respond_to do |format|
        if @comment.save
          format.html { redirect_to user_micropost_comment_url(@user, @micropost, @comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      @micropost = Micropost.find(params[:comment][:micropost_id])
      # @comment = @micropost.comments.build(comment_params)
      @comment = Comment.new(comment_params)
      @comment.user = @user

      respond_to do |format|
        if @comment.save
          # format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
          format.html { redirect_to micropost_comment_url(@micropost, @comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def user_not_found
    flash[:alert] = "User not found" # Optionally, set a flash message
    redirect_to new_micropost_comment_path(@micropost) # Redirect to a different page, e.g., the root page
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commenter, :body, :micropost_id, :user_id)
    end
end
