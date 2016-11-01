class Api::V1::UsersController < Api::V1::AuthController
  skip_before_action :authenticateRequest!, only: [:create]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      authenticate
    else
      render json: { errors: user.errors },
             status: :unprocessable_entity
    end
  end

  def update
    # TODO create user#update
  end

  def destroy
    # TODO create user#destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
