# DPCycleScrollViewDemo

>a cycleScrollView with swift，用swift写的轮播banner。


刚接触swift，代码不是很精简，后续功能持续更新，喜欢的朋友可以star一波。
可以DIY分页控制器位置样式，标题样式等。

### 一、创建方法

#### 1 加载本地图片
    
```objc
/**
 * 本地图片轮播初始化方式
 * parameter frame           	frame
 * parameter imageNamesGroup 	本地图片数组
 * returns 						轮播图对象
*/
class func initCycleScrollView(_ frame: CGRect, imageNamesGroup: NSArray, delegate: DPCycleScrollViewDelegate) -> DPCycleScrollView {

let cycleScrollView = DPCycleScrollView(frame: frame)
cycleScrollView.localizationImageNamesGroup = imageNamesGroup
cycleScrollView.delegate = delegate

return cycleScrollView
}
```
#### 2 加载网络图片
```objc
/**
 * 网络图片轮播初始化方式
 * 
 * parameter frame   			frame
 * parameter placeholderImage	占位图
 * parameter delegate       	delegate
	
 * returns						轮播图对象
*/
class func initCycleScrollView(_ frame: CGRect, placeholderImage: UIImage, delegate: DPCycleScrollViewDelegate) -> DPCycleScrollView {

let cycleScrollView = DPCycleScrollView(frame: frame)
cycleScrollView.delegate = delegate
cycleScrollView.placeholderImage = placeholderImage

return cycleScrollView
}
```
### 一、gif示例

![image](https://github.com/Deyupy/DPCycleScrollViewDemo/blob/master/DPCycleScrollViewDemo/Resource/screen.gif?raw=true)
