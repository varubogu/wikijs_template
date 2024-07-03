#!bin/bash

if [ -z "$1" ]; then
  echo "プロジェクト名を指定してください。"
  exit 1
fi

PROJECT_NAME=$1

# テンプレートをコピー
rsync -av --progress .template/ $PROJECT_NAME

if [ $? -ne 0 ]; then
  echo "Failed to copy template."
  exit 1
fi

# プロジェクト内のフォルダ内のファイルを全て、「xxxxxx」という文字をプロジェクト名に置き換える
grep -rl "xxxxxx" $PROJECT_NAME | xargs sed -i "s/xxxxxx/$PROJECT_NAME/g"

if [ $? -ne 0 ]; then
  echo "Failed to replace text in files."
  exit 1
fi

# プロジェクトフォルダ内の.env.exampleを.envに名前変更
mv $PROJECT_NAME/.env.example $PROJECT_NAME/.env

if [ $? -ne 0 ]; then
  echo ".env.exampleの名前変更に失敗しました。"
  exit 1
fi



