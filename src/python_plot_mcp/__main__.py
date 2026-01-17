#!/usr/bin/env python3
"""python-plot-mcp 命令行入口点

支持 uvx 直接运行: uvx python-plot-mcp
支持 HTTP 服务器: uvx python-plot-mcp-http
"""

import asyncio
import os
from python_plot_mcp.server import main as stdio_main
from python_plot_mcp.server_http import main as http_main


def main() -> None:
    """STDIO 模式入口点（默认）"""
    asyncio.run(stdio_main())


def main_http() -> None:
    """HTTP 服务器入口点"""
    from python_plot_mcp.server_http import sync_main
    sync_main()


if __name__ == "__main__":
    # 如果设置了环境变量 HTTP_SERVER=true，则启动 HTTP 服务器
    if os.environ.get("HTTP_SERVER", "").lower() == "true":
        main_http()
    else:
        main()
