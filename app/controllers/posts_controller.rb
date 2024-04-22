class PostsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :check_if_owns?, except: [:index, :new, :create]
  before_action :redirect_if_not_owns, except: [:index, :show, :new, :create]
  before_action :load_tags, except: [:new, :create, :destroy, :index]

  # GET /posts or /posts.json
  def index
    # page = params[:page].to_i
    @pagy, @posts = pagy(Post.order("created_at DESC"))
    # @posts = Post.order(:created_at).limit(3).offset(3*page)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    @comments = @post.comments.all

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post.tags.clear
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      p = params.require(:post).permit(:title, :content, :thumbnail, :snippet, tags: [])
      if p[:tags] == nil or p[:tags].empty?
        return p
      end
      c = p[:tags].map do |tag_name|
        t = Tag.find_by(name: tag_name)
        if not t.nil?
          t
        else
          Tag.create(name: tag_name)
        end
      end
      p[:tags] = c
      p
    end

    def check_if_owns?
      @user_owns = current_user.id == @post.user_id if current_user != nil
    end

    def redirect_if_not_owns
      redirect_to posts_path unless @user_owns
    end
    def load_tags
      @tags = @post.tags.all
    end
end
