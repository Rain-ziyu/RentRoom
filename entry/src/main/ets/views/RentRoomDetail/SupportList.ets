import type { ISupportItem, ISupportList } from '../../models/RentRoomData';
import rvp, { md, xl } from '../../util/responsive';

@Component
export default struct SupportList {
  @Link supportList: ISupportList

  build() {
    Column({ space: rvp(8) }) {
      Text('租住服务与保障').fontSize(xl()).fontWeight(700)
      Text('谷粒专享').grayText(12)
      Grid() {
        ForEach(this.supportList, (support:ISupportItem) => {
          GridItem() {
            Row({ space: rvp(10) }) {
              Image(support.image).width(rvp(28))
              Column() {
                Text(support.title).fontSize(md())
                Text(support.subTitle).grayText(10)
              }.alignItems(HorizontalAlign.Start)
            }.width('100%')
          }
        },  (support:ISupportItem) => support.title)
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .rowsGap(rvp(16))
      .height(rvp(76))
      .margin({ top: rvp(5) })
    }.alignItems(HorizontalAlign.Start).margin({ top: rvp(20) })
  }
}


@Extend(Text) function grayText(size: number) {
  .fontColor($r('app.color.gray')).fontSize(rvp(size))
}

