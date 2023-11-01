class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new

    puts "IN COMMENTS NEW"
    puts params
    @commenter = User.find(params[:user_id])
    @micropost = Micropost.find(params[:micropost_id])

    # if params[:comment].key?(:micropost_id)
    #   @micropost = Micropost.find(params[:micropost_id])
    # end
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    puts "PARAMS:"
    puts params
    # puts params[:comment]
    if params[:comment].key?(:micropost_id)
      # if the micropost doesn't exist, return an error
      puts "HERE"
      @micropost = Micropost.find(params[:comment][:micropost_id]) # not finding it?
      # @comment = Comment.new(comment_params)
      puts "HERE2"
      @comment = @micropost.comments.build(comment_params)

      respond_to do |format|
        if @comment.save
          format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      @comment = Comment.new(comment_params)
      # puts "COMMENT:"
      # puts @comment
      respond_to do |format|
        if @comment.save
          format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end

    end
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
      # puts "params:"
      # puts params
      params.require(:comment).permit(:commenter, :body, :micropost_id)
    end
end
