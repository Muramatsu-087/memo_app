class AddUserToMemos < ActiveRecord::Migration[8.0]
  def change
    # まず null 許容で user_id を追加
    add_reference :memos, :user, foreign_key: true, null: true

    # 既存のメモにユーザーを割り当てる
    user = User.first
    if user.present?
      Memo.update_all(user_id: user.id)
    else
      # ユーザーがいない場合は、テスト用ユーザーを作成
      user = User.create!(email: "test@example.com", password: "password")
      Memo.update_all(user_id: user.id)
    end

    # null: false に変更
    change_column_null :memos, :user_id, false
  end
end
