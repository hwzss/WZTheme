## WZTheme
用于公司App节日主题更新代码

### 使用方式

先在自己项目里给个默认主题的资源文件，如demo里的main.bundle文件
然后在里面放入默认主题的图片，如需从网络下下载新的主题包只要将这个main.bundle文件复制出来然后将新的主题的图片放入里面，在上传到自己公司的服务器，然后通过接口拿到这里链接，接着在代码里下载主题就可以了。代码如下：

#### 设置默认主题代码:

```

[[WZThemeManger manger] defaultThemeWithBunldeName:@"main" themeName:@"默认主题"];
    
```
#### 下载新主题代码:

```

[[WZThemeManger manger] downloadThemeFrom:@"https://github.com/hwzss/WZTheme/raw/master/theme.zip" themeName:@"github上新的主题"];
```
#### 主题更新：

```

[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(主题更新后你需要做处理的方法) name:WZThemeMangerDidSetNewAppThemeNotification object:nil]; 
```

#### 快捷设置UI主题
这里提供了一些方便的主题UI设置方法，这样在新主题更新时，您不需要注册 WZThemeMangerDidSetNewAppThemeNotification 来重新更新UI，它们会自动重新设置
1. UIView

```
- (void)wz_setBackgroundColorWithName:(NSString *)colorName;
```

2. UIButton

```

- (void)wz_setImageWithName:(NSString *)imageName forState:(UIControlState)state;

- (void)wz_setBackgroundImageWithName:(NSString *)imageName forState:(UIControlState)state;
```

3. UIImageView

```
-(void)wz_setImageWithName:(NSString *)imageName;
```

4. UITabBarItem

```
/**
 设置tabbarItem.image

 @param imageName 主题图片名称
 @param renderingMode 渲染模式
 */
- (void)wz_setNormalImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

/**
 设置tabbarItem.selectedImage
 
 @param imageName 主题图片名称
 @param renderingMode 渲染模式
 */
- (void)wz_setSelectedImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;
```


最近刚弄这块代码，如果您刚好看到这块代码，有兴趣或者对这代码有什么好的优化方案或者更好的实现方法可以联系我，或者在issue里留言。

# 更新
1. 添加UIButton支持，支持设置view背景色
2. 添加UITabBarItem设置背景图


# demo代码

```
[self.aImageV wz_setImageWithName:@"电费@3x"];
[self.secondImageV wz_setImageWithName:@"主题云钥匙选中状态@3x"];
[self.aBtn wz_setImageWithName:@"主题云钥匙选中状态@3x" forState:UIControlStateNormal];
[self.aBtn wz_setImageWithName:@"电费@3x" forState:UIControlStateSelected];
[self.view wz_setBackgroundColorWithName:@"ThemeBackColor"];
```

# 效果图:


![效果](https://github.com/hwzss/WZTheme/blob/master/demo.gif)


