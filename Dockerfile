
FROM python:3.11-slim

# 添加路径
ADD . /app
WORKDIR /app

# 更新系统
RUN apt-get update && apt-get install -y gnupg2 curl wget unzip ca-certificates


# 如果是x86架构的处理器，安装google-chrome
RUN if [ "$(uname -m)" = "x86_64" ]; then \
        # 安装 Chrome WebDriver
        CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
        mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
        curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
        unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
        rm /tmp/chromedriver_linux64.zip && \
        chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
        ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver && \
        # 安装 Chrome browser
        curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
        echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
        apt-get -y update && \
        apt-get -y install google-chrome-stable && \
        rm -rf /var/lib/apt/lists/*; \
    else \
        apt-get -y update && \
        apt-get -y install chromium; \
    fi


RUN pip install DrissionPage
CMD tail -f /dev/null




# 定义容器启动时执行的命令
#ENTRYPOINT ["python", "test.py"]
