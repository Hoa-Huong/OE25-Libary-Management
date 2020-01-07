class Admin::UsersController < AdminController
  before_action :find_user, except: %i(new index)

  def new
    @user = User.new
  end

  def index
    @users = User.order_by_create_at.page(params[:page]).per Settings.page_user
  end

  def show
    respond_to :js
  end

  def edit
    respond_to :js
  end

  def update
    if @user.update user_params
      flash[:success] = t "profile_update"
      redirect_to admin_users_path
    else
      flash[:danger] = t "update_false"
      render :edit
    end
  end

  def destroy
    begin
      @user.destroy!
      flash[:success] = t "delete_success"
    rescue StandardError
      flash[:danger] = t "delete_user_fail"
    ensure
      redirect_to admin_users_path
    end
  end


  private

  def find_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
