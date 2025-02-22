class MasksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]
  def top
    @rank_masks = Mask.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
  end

  def index
    @masks = Mask.all
    if params[:search] == nil
      @masks= Mask.all
    elsif params[:search] == ''
      @masks= Mask.all.order(created_at: :desc)
    else
      @masks = Mask.where("mask_name LIKE ? ",'%' + params[:search] + '%')
    end
    @masks = @masks.page(params[:page]).per(6)
  end

  def new
    @mask = Mask.new
  end
    
  def create
    @mask = Mask.new(mask_params)
    Rails.logger.debug "受け取ったパラメータ: #{params.inspect}" # ここでパラメータをログ出力
    @mask = Mask.new(mask_params)
    @mask.user = current_user # 投稿者を設定
    if params[:post] # 「投稿公開」ボタンが押された場合
      @mask.is_draft = false
      if @mask.save(context: :publicize)
        redirect_to masks_path, notice: "投稿が公開されました！"
      else
        Rails.logger.debug "投稿エラー: #{@mask.errors.full_messages}" # エラーの内容をログ出力
        flash.now[:alert] = @mask.errors.full_messages.join(", ") # ユーザーにエラーメッセージを表示
        render :new, status: :unprocessable_entity
      end
    elsif params[:draft] # 「下書き保存」ボタンが押された場合
      @mask.is_draft = true
      if @mask.save
        redirect_to user_path(current_user), notice: "下書きを保存しました！"
      else
        Rails.logger.debug "下書き保存エラー: #{@mask.errors.full_messages}" # エラーをログ出力
        flash.now[:alert] = @mask.errors.full_messages.join(", ") # エラーメッセージをユーザーに表示
        render :new, status: :unprocessable_entity
      end
    else
      Rails.logger.debug "ボタンが押されていません"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    unless params[:id] =~ /^\d+$/
       redirect_to masks_path, alert: "無効なIDです"
       return
    end
    @mask = Mask.find(params[:id])
  end

  def edit
    @mask = Mask.find(params[:id])
  end

  def update
    @mask = Mask.find(params[:id])
    @mask.is_draft = params[:draft].present?
    if @mask.update(mask_params)
      if @mask.is_draft?
        redirect_to users_path(current_user), notice: "下書きを更新しました"
      else
        redirect_to masks_path(@mask), notice: "ツイートを更新しました"
      end
    else
        render :edit
    end
  end

  def drafts
    @masks = Mask.where(is_draft: true, user_id: current_user.id)
  end

  def destroy
    mask = Mask.find(params[:id])
    mask.destroy
    redirect_to action: :index
  end

    private
    def mask_params
        params.require(:mask).permit(:mask_name, :body, :skintype, :image, :nom, :name, :overall, :is_draft)
    end
end


#@mask = Mask.new(mask_params)
    # 投稿ボタンを押下した場合
    #if params[:post]
       #if @mask.save(context: :publicize)
      #redirect_to @mask => "index"
      # else
      #render :new
       #end
    # 下書きボタンを押下した場合
    #else
      #if @mask.update(is_draft: true)
      #redirect_to user_path(current_user)
      #else
      #Rails.logger.debug "投稿エラー: #{@mask.errors.full_messages}" # ログにエラーを出力
      #render :new
      #end
#end