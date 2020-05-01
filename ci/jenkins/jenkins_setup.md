## Jenkins笔记：安装和配置

Jenkins的安装和配置是一项体力活，本笔记将记录在`Mac OS`上配置Jenkins服务；

### 配置

在安装`Jenkins`之前，你需要配置好环境：

- 安装`JDK 1.8`或以上，推荐`1.8`，省心；
- 安装`Homebrew`，使用官方的命令如果出现`curl 443 Connection refused`的错误时，可以尝试先把`install.sh`的脚本下载下来，然后在本地执行，在`install.sh`脚本执行过程中，如果又出现`curl 443 Connection refused`的错误时，尝试把`install.sh`脚本中的https连接改成http；
- 使用`brew install jenkins-lts`安装LTS版本；
- 安装后的`jenkins`在`~/.jenkins`目录下

### 常用命令

```shell
# 开启服务
brew services start jenkins-lts

# 停止服务
brew services stop jenkins-lts

# 重启服务
brew services restart jenkins-lts

# 设置开机启动
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins-lts.plist

# 关闭开机启动
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins-lts.plist
```
