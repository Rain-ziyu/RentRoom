import { BORDER_RADIUS_S, PADDING, SHADOW_RADIUS } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"


@Component
export default struct FindRoom {
  @StorageProp('topHeight') topHeight: number = 0

  build() {

    Column() {

      Image($r('app.media.find_room')).width(60).height(23).margin({ left: 4 })

      Text("发现你想要的房子").margin({ left: 4, top: 20 }).fontSize(12).fontColor($r('app.color.black'))
      Image($r('app.media.blank')).width(234).height(221).alignSelf(ItemAlign.Center).margin({ top: 7 })
      Text("暂无想看房源，试试如下找房方式")
        .width('100%')
        .margin({ left: 4, top: 20 })
        .fontSize(12)
        .fontColor($r('app.color.black'))
      Row() {
        Row({ space: 5 }) {
          Image($r('app.media.bus')).width(34).height(34).objectFit(ImageFit.Fill)
          Column({ space: 5 }) {
            Text('通勤找房').fontSize(16)
            Text('按公司通勤时长找房').fontSize(12).fontColor($r('app.color.gray'))
          }.alignItems(HorizontalAlign.Start)
        }

        Row({ space: 5 }) {
          Image($r('app.media.map')).width(34).height(34).objectFit(ImageFit.Fill)
          Column({ space: 5 }) {
            Text('地图找房').fontSize(16)
            Text('在你想住的地方找房').fontSize(12).fontColor($r('app.color.gray'))
          }.alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')
      .margin({ top: 20 })
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius(BORDER_RADIUS_S)
      .shadow({
        radius: SHADOW_RADIUS,
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 0
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: 54,
      left: PADDING,
      right: PADDING
    })

  }
}