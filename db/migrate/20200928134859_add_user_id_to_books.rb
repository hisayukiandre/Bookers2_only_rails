class AddUserIdToBooks < ActiveRecord::Migration[5.2]
  def change

    # 既に作成したテーブルにカラムを追加したい場合
    # ターミナルで rails g migration Addカラム名Toテーブル名 カラム名:型名
    add_column :books, :user_id, :integer
  end
end
