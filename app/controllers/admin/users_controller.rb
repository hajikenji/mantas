class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :protect_from_general_user

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @tasks = User.find_by(id: params[:id]).tasks
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @for_model_validate = params[:user][:admin]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    
    # flash[:danger] = "このユーザーを消去すると管理者が0人になります。" unless @user.destroy
    @user.destroy
    # redirect_to admin_users_path, notice: "User was successfully destroyed."
    redirect_to admin_users_path, notice: @user.errors.messages[:notice].first #エラー文出す用

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def protect_from_general_user
      unless current_user.admin
        redirect_to tasks_path
        flash[:danger] = '管理者権限がありません'
      end
    end
end
