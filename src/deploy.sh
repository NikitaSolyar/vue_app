#!/usr/bin/evn sh

# остановить публикацию при ошибках
set -e

# сборка приложения
npm run build

# переход в каталог сборки
cd dist

# иницилизация репозитория и загрузка на гитхаб
git init
git add -A
git commit -m 'deploy'

git push -f git@github.com/NikitaSolyar/vue-app.git master gh:pages

cd -