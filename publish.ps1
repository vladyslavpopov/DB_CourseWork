$ErrorActionPreference = "Stop"

npm run docs:build

Set-Location -Path "./docs/.vuepress/dist"

New-Item -ItemType File -Name ".nojekyll"

git init
git add -A
git commit -m "deploy"

git push -f https://github.com/vladyslavpopov/DB_CourseWork master:gh-pages

Set-Location -Path "../../.."

