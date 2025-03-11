import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import { IServiceActivity, IVipServiceItem, IVipServiceList } from "../../models/ServiceData"
import { DEFAULT } from "@ohos/hypium"
import { CardRecognition } from "@hms.ai.CardRecognition"
import Card from "../../components/Card/Index"


@Component
export default struct ServiceCalendar {
  @StorageProp('topHeight') topHeight: number = 0
  @Prop serviceActivity: IServiceActivity = {
    name: "",
    img: "",
    title: "",
    subTitle: ""
  }

  build() {

    Column(){
      Card({cardPadding:0}){
        Row() {
          Text('服务日历').fontSize(16).fontColor($r('app.color.black')).fontWeight(700)
          Row({ space: 10 }) {
            Text('全部服务').fontSize(12).fontColor($r('app.color.gray'))
            Image($r('app.media.arrow_right')).width(4).height(9).fillColor($r('app.color.gray'))
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({left:8})


    }
  }.width('100%').margin({top :8})
}
}