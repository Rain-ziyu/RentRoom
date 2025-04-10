import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import { IColor } from "../../models/HomeData"


@Component
export default struct NavBar {
@Prop fontColor:string;
  build() {

    Row() {
      Row({ space: 6 }) {

        Text('请选择地址').fontSize(12).fontColor(this.fontColor)
        Image($r('app.media.arrow_down')).width(6).height(6).margin({bottom:3}).fillColor(this.fontColor)
      }

      Row({ space: 28 }) {
        Column({ space: 1 }) {
          Image($r('app.media.message')).width(20).height(20).fillColor(this.fontColor)
          Text('消息').fontSize(10).fontColor(this.fontColor)
        }

        Column({ space: 1 }) {
          Image($r('app.media.customer')).width(20).height(20).fillColor(this.fontColor)
          Text('客服').fontSize(10).fontColor(this.fontColor)
        }
      }
    }
    .width('100%')
    .height(44)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: PADDING, right: PADDING })
  }
}