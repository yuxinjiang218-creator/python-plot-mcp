# 使用官方 Python 运行时作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8000

# 安装系统依赖（matplotlib 需要）
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用文件（使用新的包结构）
COPY src/ ./src/
COPY pyproject.toml .

# 安装包
RUN pip install -e .

# 暴露端口（Render 会自动设置 PORT 环境变量）
EXPOSE 8000

# 启动命令 - 使用 HTTP 服务器模式
CMD ["python", "-m", "python_plot_mcp.server_http"]
