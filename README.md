# SCHLiveDY
模仿斗鱼直播
GitHub代码地址：https://github.com/SiSmile/SCHLiveDY
首页思路：
1.封住SCHPageTitleView
     （1）自定义View，并且自定义构造函数
     （2）添加自定义控件：UIScrollView
2.封住SCHContentView
     （1）自定义View，并且自定义构造函数
     （2）添加自定义控件：UICollectionView
3.处理SCHPageTitleView和SCHContentView的逻辑
        (1)  SCHPageTitleView中发生点击
                    SCHPageTitleView自身发生逻辑变化
                    告知SCHContentView中滚动到正确的控制器
        (2) SCHContentView中发生滚动

