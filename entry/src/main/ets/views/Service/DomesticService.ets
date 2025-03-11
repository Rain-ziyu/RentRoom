import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import Card from '../../components/Card/Index'
import { IHomeServiceItem, IHomeServiceList } from "../../models/ServiceData"

@Component
export default struct DomesticService {
  @StorageProp('topHeight') topHeight: number = 0
  @Prop homeServiceList: IHomeServiceList = []

  build() {
    Column() {
      Card() {
        Row() {
          Text('家庭服务').fontSize(16).fontColor($r('app.color.black')).fontWeight(700)
          Row({ space: 10 }) {
            Text('全部服务').fontSize(12).fontColor($r('app.color.gray'))
            Image($r('app.media.arrow_right')).width(4).height(9).fillColor($r('app.color.gray'))
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)

        Grid() {
          ForEach(this.homeServiceList, (item: IHomeServiceItem) => {
            GridItem() {
              Column({space:9}) {
                Image(item.icon).width(24).height(24).objectFit(ImageFit.Fill)
                Text(item.title).fontColor($r('app.color.black')).fontSize(12)
              }
            }
          }, (item: IHomeServiceItem) => item.title)
        }.height(187).width('100%').columnsTemplate('1fr 1fr 1fr 1fr 1fr').rowsGap(23)
        .margin({top:20})
      }
    }
    .width('100%').margin({ top: 43 })

  }
}