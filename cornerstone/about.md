# cornerstone分析

Cornerstone是一个用于展示包含且不限于DICOM协议的可交互的医学图像Javascript仓库；

## 整体结构

Cornerstone将库进行模块化以便它既可以单独也可以组合使用；Cornerstone Core库是Cornerstone生态中的核心库，除了核心库外，Cornerstone团队还提供其他的库，其主要分成下面几个库：

- Cornerstone Core: 提供图片渲染，加载，缓存以及视口转换；
- Cornerstone Tools: 对构建工具的可扩展支持，以及支持鼠标、键盘和触控设备；
- Cornerstone WADO Image Loader: DICOM Part 10文件的图片加载器；
- Cornerstone Web Image Loader: Web图片(PNG, JPEG)的图片加载器；
- Cornerstone Math: 用于支持工具开发的数学类工具function和class；
- discomParser: 健壮的DICOM Part 10文件解析库；

cornerstone
