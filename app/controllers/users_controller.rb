class UsersController < ApplicationController

  before_action :authenticate_user!, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  wrap_parameters :user, include: [:name, :password, :password_confirmation]

  def index
    @users = User.all
    @search = User.ransack(params[:q])
    @re_users = @search.result
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image_name: "default_user.png",
      back_image: "default-b.png"
    )


    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/user_images/#{@user.image_name}", image.read)
    end

    if params[:bimage]
      @user.back_image = "#{@user.id}.jpg"
      image = params[:bimage]
      File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/back_images/#{@user.back_image}", image.read)
    end

    if @user.save
      flash[:notice] = "変更を保存しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  # def login_form
  # end

  # def login
  #   @user = User.find_by(email: params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] = @user.id
  #     flash[:notice] = "ログインしました"
  #     redirect_to("/posts/index")
  #   else
  #     @error_message = "メールアドレスまたはパスワードが間違っています"
  #     @email = params[:email]
  #     @password = params[:password]
  #     render("users/login_form")
  #   end
  # end
  #
  # def logout
  #   session[:user_id] = nil
  #   flash[:notice] = "ログアウトしました"
  #   redirect_to("/login")
  # end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def follows
    @follow_users = current_user.followings
  end

  # def followers
  #   @user = User.find_by(id: params[:id])
  #   @follower_users = @user.followers(follower_id: @user.id)
  # end

  def search
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end




end
