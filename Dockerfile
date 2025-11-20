# 使用官方 Python 镜像作为基础镜像
FROM registry.cn-shanghai.aliyuncs.com/mlabs/python:3.12-slim

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y \
    google-chrome-stable \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
ENV PIP_TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn
ENV PLAYWRIGHT_DOWNLOAD_HOST=https://npmmirror.com/mirrors/playwright

# 设置工作目录在容器内
WORKDIR /app

# 将本地代码复制到容器内的 /app 目录中
COPY . /app

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install chromium && playwright install-deps

# 指定容器启动时执行的命令
CMD ["python", "./src/uitests/app.py"]
