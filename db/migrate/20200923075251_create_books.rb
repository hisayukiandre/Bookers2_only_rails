class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

# Book.column_namesでカラム名を確認できる

# railsでモデルとテーブルを作成するときはターミナルで
# rails g model モデル名 カラム名1:データ型1 カラム名2:データ型2 ...
# しかし、このときテーブルはまだ作成されていない(rails db:migrateをするとテーブルが作成される)
# だから、テーブル作成後にカラムを追加したい場合は
# rails g migration Addカラム名Toテーブル名 カラム名:型名
# で追加する必要がある.(t.string : nameなどと上に書いてdb:migrateしても意味がない)