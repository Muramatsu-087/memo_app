class MemosController < ApplicationController
  before_action :set_memo, only: %i[show edit update destroy]

  # メモ一覧
  def index
    @memos = Memo.all.order(created_at: :desc)
  end

  # 新規作成ページ
  def new
    @memo = Memo.new
  end

  # 作成処理
  def create
    @memo = Memo.new(memo_params)
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

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
