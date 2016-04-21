class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote]
before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :upvote]
before_filter :check_user, only: [:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 4).order("created_at DESC")
    
     @post = Post.new
     @categories = Category.all.map{|c| [c.name, c.id]}

     if params[:category].present?
    category_id = Category.find_by(name: params[:category]).try(:id)
    @posts = @posts.where(category_id: category_id) if category_id
  end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  # GET /posts/1/edit
  def edit
      @categories = Category.all.map{|c| [c.name, c.id]}
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     @post.category_id = params[:category_id]

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: root_url }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
       @post.category_id = params[:category_id]
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def upvote 
    @post.upvote_by current_user
    redirect_to :back

  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:message, :category_id)
    end

     def check_user
       if current_user != @post.user
          redirect_to root_url, alert: "Sorry, dont permission"
    end 
    end
end
