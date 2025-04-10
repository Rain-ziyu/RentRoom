import Home from './Home'
import My from './My'
import See from './See'
import Service from './Service'
import Discover from './Discover'
import { window } from '@kit.ArkUI'
// 需要放到app的第一个页面进行初始化持久化存储
PersistentStorage.persistProp('token', '')
@Entry
@Component
struct Index {
  @State currentTabBarIndex: number = 0;
  @StorageProp('botHeight') bottomHeight: number = 0

  @Builder
  tabBarBuilder(image: Resource, activeImage: Resource, text: string, index: number) {
    Column() {
      Image(this.currentTabBarIndex == index ? activeImage : image).width(28).height(28)
      Text(text).fontSize(10).fontColor('#A0A0A0')
    }
  }

  windowClass?: window.Window
  // 设置 window 状态栏颜色
  setWindowStatusColor = async (color: string) => {
    this.windowClass = await window.getLastWindow(getContext())
    this.windowClass!.setWindowSystemBarProperties({
      statusBarContentColor: color,

    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentTabBarIndex }) {
      TabContent() {
        Home()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

      TabContent() {
        See()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '看看', 1))

      TabContent() {
        Service()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '服务', 2))

      TabContent() {
        Discover()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 3))

      TabContent() {
        My()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))
    }.barHeight(50 + this.bottomHeight)

    .scrollable(false)
    .onChange((index: number) => {
      this.currentTabBarIndex = index
      if (index === 1) {
        this.setWindowStatusColor('#000000')
      } else {
        this.setWindowStatusColor('#FFFFFF')
      }
    })
  }
}