class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
    @public_posts = Post.where(user_id:1).sample(3)

    @task_search.sorts = 'created_at desc' if @task_search.sorts.empty?
    @re_posts = @task_search.result
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @liked_users = @post.liked_users
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:title],
      content: params[:content],
      user_id: current_user.id,
      limitday: params[:limitday],
      tie: params[:tie],
      place: params[:place],

      # post_image: params[:pimage]
     )

     # unless @post.save
     #   render("posts/new")
     # end

     # if params[:pimage]
     #   @post.post_image = "#{SecureRandom.uuid}.jpg"
     #   image = params[:pimage]
     #   File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/post_images/#{@post.post_image}", image.read)
     # end


    if @post.save
      flash[:notice] = "TASKを作成！！さぁ、チャレンジしよう！！"
      redirect_to posts_index_path
    else
      flash[:alert] = "作成時にエラーが発生しました"
      redirect_to posts_new_path
    end


  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    @post.limitday = params[:limitday]
    @post.place = params[:place]
    @post.post_image = params[:pimage]
    @post.tie = params[:tie]

    # if params[:pimage]
    #   @post.post_image = "#{SecureRandom.uuid}.jpg"
    #   image = params[:pimage]
    #   File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/post_images/#{@post.post_image}", image.read)
    # end

    if @post.save
      flash[:notice] = "編集が完了しました"
      redirect_to posts_path(@post)
    else
      flash[:alert] = "編集に失敗しました"
      redirect_to posts_path(@post)
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      flash[:notice] = "TASKを削除しました"
      redirect_to posts_index_path
    else
      flash[:alert] = "TASKの削除に失敗しました"
      redirect_to posts_path(@post)
    end
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to posts_index_path
    end
  end

end
