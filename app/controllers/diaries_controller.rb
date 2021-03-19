class DiariesController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :set_new_diary, except: [:show, :edit]

  def index
    if customer_signed_in?
      following_ids = current_customer.followings.pluck(:id)
      blocking_ids = current_customer.blockings.pluck(:id)
      # @diaries = Diary.where(customer_id: following_ids).where.not(customer_id: blocking_ids).page(params[:page]).per(20)
      @diaries = Diary.includes(:customer, :check_list_diaries, :diary_images, :diary_favorites, :diary_comments).order("created_at DESC").page(params[:page]).per(20)
    else
      @diaries = Diary.includes(:customer, :check_list_diaries, :diary_images, :diary_favorites, :diary_comments).order("created_at DESC").page(params[:page]).per(20)
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @new_diary = Diary.new
    @check_list_diary = @new_diary.check_list_diaries.new
    @diary_comment = DiaryComment.new
  end

  def new
  end

  def create
    @diary = current_customer.diaries.new(diary_params)
    if @diary.title.blank?
      @diary.title = "日記"
    end
    if @diary.save
      #チェックされていないリストのcheck_list_diary(中間テーブル)を作成
      current_customer.trying_diet_methods.each do |method|
        check_list_ids = method.check_lists.pluck(:id)
        check_list_ids.each do |check_list_id|
          @diary.check_list_diaries.where(check_list_id: check_list_id).first_or_create do |check_list_dairy|
            check_list_dairy.status = "false"
          end
        end
      end
      level_up(20, current_customer)
      previous_diary = current_customer.diaries.first(2)[1]
      if previous_diary.present?
        level_up(previous_diary.weight * 10 - @diary.weight * 10, current_customer)
        level_up(previous_diary.body_fat_percentage * 30 - @diary.body_fat_percentage * 30, current_customer)
      end
      customer_ids = Relationship.where(followed_id: current_customer.id, notification: true).pluck(:follower_id)
      Customer.where(id: customer_ids).each do |customer|
        customer.create_notification_diary(current_customer, @diary)
      end
      flash[:notice] = "日記を投稿しました"
      redirect_to diaries_path
    else
      @diary.check_list_diaries.destroy_all
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @new_diary = Diary.new
    @check_list_diary = @new_diary.check_list_diaries.new
  end

  def update
    diary = Diary.find(params[:id])
    if diary.update(diary_params)
      diary.check_list_diaries.update(status: false)
      CheckListDiary.where(id: params[:diary][:check_list_diary][:id]).update(status: true)
      flash[:notice] = "日記を編集しました"
      redirect_to diary_path(diary)
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body, :weight, :body_fat_percentage, :post_date, diary_images_images: [], check_list_diaries_attributes: [:check_list_id, :_destroy, :id])
  end
end
