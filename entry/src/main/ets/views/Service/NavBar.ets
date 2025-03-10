import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"



@Component
export default struct NavBar {
  @StorageProp('topHeight') topHeight: number = 0

  build() {

    Row() {
      Row({ space: 6 }) {

        Text('请选择地址').fontSize(12).fontColor($r('app.color.white'))
        Image($r('app.media.arrow_down')).width(6).height(6).margin({bottom:3})
      }

      Row({ space: 28 }) {
        Column({ space: 1 }) {
          Image($r('app.media.message')).width(20).height(20).fillColor($r('app.color.white'))
          Text('消息').fontSize(10).fontColor($r('app.color.white'))
        }

        Column({ space: 1 }) {
          Image($r('app.media.customer')).width(20).height(20)
          Text('客服').fontSize(10).fontColor($r('app.color.white'))
        }
      }
    }
    .width('100%')
    .height(44)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: PADDING, right: PADDING })
    .margin({ top: this.topHeight })
  }
}