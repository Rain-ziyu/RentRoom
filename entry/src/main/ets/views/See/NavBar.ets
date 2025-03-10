import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import FindRoom from "./FindRoom"


@Component
export default struct NavBar {
  @StorageProp('topHeight') topHeight: number = 0

  build() {

    Row() {
      Row({ space: 6 }) {
        Image($r('app.media.bag')).width(16).height(16)
        Text('填写通勤地址').fontSize(12).fontColor($r('app.color.black'))
      }

      Row({ space: 28 }) {
        Column({ space: 1 }) {
          Image($r('app.media.message')).width(20).height(20).fillColor($r('app.color.black'))
          Text('消息').fontSize(10).fontColor($r('app.color.black'))
        }

        Column({ space: 1 }) {
          Image($r('app.media.journey')).width(20).height(20)
          Text('行程').fontSize(10).fontColor($r('app.color.black'))
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