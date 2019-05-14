class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
    @search = Post.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @re_posts = @search.result
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
    @newpost = Post.new(
      title: params[:title],
      content: params[:content],
      user_id: current_user.id,
     )

     unless @newpost.save
       render("posts/new")
     end 

     if params[:pimage]
       @newpost.post_image = "#{@newpost.id}.jpg"
       image = params[:pimage]
       File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/post_images/#{@newpost.post_image}", image.read)
     end


    if @newpost.save
      flash[:notice] = "TASKを作成！！さぁ、チャレンジしよう！！"
      redirect_to('/posts/index')
    else
      render("posts/new")
    end


  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]

    if params[:pimage]
      @post.post_image = "#{@post.id}.jpg"
      image = params[:pimage]
      File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/post_images/#{@post.post_image}", image.read)
    end

    if @post.save
      flash[:notice] = "編集が完了しました"
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "TASKを削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
