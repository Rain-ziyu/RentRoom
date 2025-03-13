import { IColor } from "../../models/HomeData";
import { router, window } from "@kit.ArkUI";
import { BORDER_RADIUS, PADDING } from "../../constants/size";

@Component
export default struct Index {

@Prop title :string
  build() {
    Stack() {

      Text(this.title).fontColor($r('app.color.black')).fontSize(16).width('100%').textAlign(TextAlign.Center)
      Image($r('app.media.back')).width(24).height(24).onClick(()=>{
        router.back()
      })
    }.width('100%').height(44).padding({left:PADDING,right:PADDING})
    .align(Alignment.Start)
  }
}