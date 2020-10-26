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

Image Id的URL scheme决定了Cornerstone在加载图片时需要调用哪一个Image Loader；这种策略也让Cornerstone可以同时展示从不同服务器上获取的不同协议的多张图片；例如，Cornerstone可以展示通过WADO获取的DICOM CT图像，同时也可以展示一张由数码相机拍摄并且存储在文件系统中的JPEG格式的皮肤科图片；

## Image Loader

> Image Loader是一个Javascript函数，这个函数负责为图片解析`Image Id`并且返回图片对应的`Image Load Object`给Cornerstone；`Image Load Object`包含一个Promise，这个Promise的状态为resolve时，会产生`Image`；

由于加载图片时通常会发起对服务器的请求，因此图片加载的API必须是异步的；Cornerstone要求Image Loader返回一个包含Promise的对象，这个Promise将会被Cornerstone用于异步接收图片对象，以及接收可能产生的Error；

### Image Loader 工作流

![Image Loader工作流](./image-loader-workflow.png)

- 1、ImageLoader将会与Cornerstone一起注册以便去加载特定`ImageId`的URL Scheme；
- 2、应用通过loadImage()API发起请求加载图片；
- 3、Cornerstone将加载图片的过程代理给`ImageLoader`；
- 4、`ImageLoader`将会返回一个包含`Promise`的`Image Load Object`，这个`Promise`的状态将会被`resolved`，并且返回对应的`Image Object`一旦它接收到像素数据；获取像素数据可能需要使用`XMLHttpRequest`发起远端调用、像素数据的解压缩、以及将像素数据转换为Cornerstone能解析的形式；
- 5、`Promise`转换为`resolved`状态并且返回`Image Object`，随后，调用displayImage()API去展示`Image Object`；

## 像素坐标系统

`Cornerstone像素坐标系统`用于引用图片中的单独像素以及支持sub-pixel(sub-pixel指的是在两个物理像素之间还有像素)精度；坐标系统的原点(0.0, 0.0)位于图片的最左上角像素里面的左上角位置，行和列则是位于图片的最右下角像素里面的右下位置；一个.5, .5的坐标值代表了最左上角像素的中点。 

- 1、pageToPixel方法用于将从浏览器事件中获取的坐标值转换为`Cornerstone像素坐标系统`中的坐标值；
- 2、setToPixelCoordinateSystem方法会被用于将canvas context设置成像素坐标系统；在处理`CornerstoneImageRendered`事件去在图像的最上层绘制几何图形时，非常有用；
- 3、坐标系统
- 4、使用Math.ceil去将像素坐标系统转换为整型的像素坐标；

## 渲染循环

> Cornerstone可操作元素的视图变化(例如，窗口化、平移、放大等等)将会通过基于`requestAnimationFrame`的渲染循环机制进行更新。 

在大部分现代浏览器当中，`渲染循环`使用`requestAnimationFrame(RAF)`函数去实现。如果`RAF`不可用时，它将被替换为使用setTimeout和clearTimeout的16ms计时器。 

渲染循环的工作流程如下：

- 1、回调函数draw将会在`RAF`调用时注册；
- 2、draw函数将会在一帧图像展示到屏幕完成后被浏览器调用；
- 3、一旦draw函数被调用
  - 如果元素已经被安排到re-rendering流程中，那么元素将会被渲染并且draw()会重新与`RAF`一起注册；
  - 如果元素没有被安排到re-rendering流程中，那么元素将不会被渲染并且draw()会重新与`RAF`一起注册；
  - 如果元素处于disabled的状态，draw()回调将不会被重新注册，并且rendering loop终止；

这就意味着：

- cornerstone.draw()和cornerstone.invalidate()并不会立即触发viewport的渲染；反而，他们会将图片标记为`需要`渲染的；
- 每一个cornerstone的元素将会注册他自己的`RAF`的循环；
- 在一个60Hz的系统中，如果渲染时间超过16ms，那么就会出现掉帧的现象；
- 尽管渲染花费的时间远远低于16ms，但是一帧只允许一次渲染；
- 所有的交互操作(如，窗口化、平移、放大...)都会被合并然后在下一帧进行渲染；
