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

## 启用元素

> 启用元素是一个用于在内部展示可交互的医学图像的HTML元素(一般是一个div)

为了展示一张图片，我们需要做以下事情：

- 1、在web页面当中通过一个script标签引用Cornerstone的Javascript库文件；
- 2、在网页当中使用一个或者多个Cornerstone用于加载像素数据的Image Loaders；
- 3、在DOM中添加一个元素用于在内部展示图片；
- 4、在页面上使用CSS属性按照所需的宽和高去定位元素；
- 5、调用enable()API去准备要展示图片的元素；
- 6、调用loadImage()API去加载图片；
- 7、调用displayImage()API展示图片；

## Image Ids

> `Cornerstone Image Id`是一个用于辨认Conerstone要展示的图片的URL；

在Cornerstone使用的Image Id的URL 

## 渲染

> Cornerstone可操作元素的视图变化(例如，窗口化、移动、放大等等)将会通过基于requestAnimationFrame的渲染循环机制进行更新.

