class MemosController < ApplicationController
  # ログインユーザーのみアクセス可能にする
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_memo, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  # メモ一覧
  def index
    # ログインユーザーごとのメモだけを表示する場合
    @memos = current_user ? current_user.memos.order(created_at: :desc) : Memo.none
    # 全員のメモを見せたい場合は上書きせず
    # @memos = Memo.all.order(created_at: :desc)
  end

  # 新規作成ページ
  def new
    @memo = Memo.new
  end

  # 作成処理
  def create
    # ログインユーザーに紐付けてメモ作成
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      redirect_to memos_path, notice: "メモを作成しました"
    else
      render :new
    end
  end

  # メモ詳細
  def show; end

  # 編集ページ
  def edit; end

  # 更新処理
  def update
    if @memo.update(memo_params)
      redirect_to memos_path, notice: "メモを更新しました"
    else
      render :edit
    end
  end

  # 削除
  def destroy
    @memo.destroy
    redirect_to memos_path, notice: "メモを削除しました"
  end

  private

  def set_memo
    @memo = Memo.find(params[:id])
  end

  # 他ユーザーのメモを編集・削除できないように制御
  def correct_user
    redirect_to memos_path, alert: "権限がありません" unless @memo.user == current_user
  end

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
