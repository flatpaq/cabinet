class GroupsController < ApplicationController

  before_action :edit_group_permit, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
      .order(slug: :desc)
      .page(params[:page])

      # .select(:slug, :name)
  end

  def show

    @group = Group.find_by(slug: params[:id])

    # @group = Group.includes(:users, {users: {user_image_attachment: :blob}}).find_by(slug: params[:id])

    @users = @group.users
      .includes({user_image_attachment: :blob})
      .order(name_id: :asc)
      .page(params[:page])

  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_url, notice: "グループ#{@group.name}を作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: "グループ#{@group.name}を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: "グループ#{@group.name}を削除しました。"
  end

  # private

  private def group_params
    params.require(:group).permit(:user_id, :slug, :name, :secret, { user_ids: [] })
  end

  private def edit_group_permit
    group = Group.find_by(slug: params[:id])
    if current_user.id == group.user_id || current_user.admin?
      @group = group
    end
  end


end
