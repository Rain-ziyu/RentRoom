import { PADDING } from "../constants/size"
import rvp from "../util/responsive"
import NavBar from "../views/See/NavBar"
import { window } from "@kit.ArkUI"
import FindRoom from "../views/See/FindRoom"

@Component
export default struct See {
  windowClass? :window.Window
  // 设置 window 状态栏颜色
  setWindowStatusColor = async () => {
    this.windowClass = await window.getLastWindow(getContext())
    this.windowClass!.setWindowSystemBarProperties({
      statusBarContentColor:'#000000',
      navigationBarContentColor:'#000000'
    })
  }
  aboutToAppear(): void {
    this.setWindowStatusColor()
  }
  build() {
    Column(){
      NavBar()
      FindRoom()
    }.width('100%').height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#DEFBE5', 0],
        ['#ffffff', 0.3],
        ['#ffffff', 1],
      ],
    })
  }
}