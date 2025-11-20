# 使用官方 Python 镜像作为基础镜像
FROM python:3.12-slim

# ENV PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
# ENV PIP_TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn
# ENV PLAYWRIGHT_DOWNLOAD_HOST=https://npmmirror.com/mirrors/playwright

# 设置工作目录在容器内
WORKDIR /app

# 将本地代码复制到容器内的 /app 目录中
COPY . /app

# 安装依赖
RUN pip install --no-cache-dir playwright openpyxl pandas Pillow
RUN playwright install chromium && playwright install-deps

# 指定容器启动时执行的命令
CMD ["python", "src/uitests/app.py"]
