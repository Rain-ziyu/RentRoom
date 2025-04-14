import type { IRentInfoItem, IRentInfoList } from '../../models/RentRoomData';
import rvp, { sm, xs } from '../../util/responsive';


@Component
export default struct RentInfo {
  @Link rentInfoList: IRentInfoList

  build() {
    Column({ space: rvp(8) }) {
      Text('租客信息').fontSize(18).fontWeight(700)
      ForEach(this.rentInfoList, (rentInfo: IRentInfoItem)=> {
        Row({ space: rvp(8) }) {
          Image(rentInfo.image).width(rvp(34))
          Text(rentInfo.title).fontSize(sm())
          Blank()
          Text(rentInfo.userTag).fontColor($r('app.color.gray')).fontSize(sm())
        }.backgroundColor('#FAF8FB').padding({ top: rvp(4), bottom: rvp(4), left: rvp(8), right: rvp(8) }).width('100%').height(rvp(42)).margin({ top: rvp(8) })
      }, (rentInfo: IRentInfoItem) => rentInfo.userTag)
      Text('*已出租房屋为您展示房屋签约人信息').fontColor($r('app.color.gray')).fontSize(xs())
    }.alignItems(HorizontalAlign.Start).margin({ top: rvp(20) })
  }
}