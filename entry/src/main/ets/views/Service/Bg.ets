import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"



@Component
export default struct Bg {
  @StorageProp('topHeight') topHeight: number = 0

  build() {

    Stack() {
      Image($r('app.media.service_bg')).width('100%').height(221-36+this.topHeight).objectFit(ImageFit.Fill)
      Image($r('app.media.arrow_down_2')).width(10).height(3).margin({bottom:14})
    }
    .width('100%')
    .alignContent(Alignment.Bottom)

  }
}