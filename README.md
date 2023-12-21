# docker-chrome-python-template
docker打包python项目，并包括Chrome和Chromedriver

# 具体内容：
- Dockerfile_all：兼容x86和ARM架构，获取不同的chrome类型
- Dockerfile：只支持ARM，只能用chromium
- 使用了DrissionPage这个python库，一个新的爬虫框架，区别于selenium 
