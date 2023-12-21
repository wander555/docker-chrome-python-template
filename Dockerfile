FROM python:3.11-slim

# 添加路径
ADD . /app
WORKDIR /app

# 更新系统
RUN apt-get update && apt-get install -y gnupg2 curl wget unzip ca-certificates build-essential

# 设置时区
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# 如果是x86架构的处理器，安装google-chrome
RUN apt-get -y install chromium

RUN pip install DrissionPage==4.0.0b24 TimePinner
CMD tail -f /dev/null
CMD ["python", "svn.py"]
