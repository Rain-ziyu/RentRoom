import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import { IVipServiceItem, IVipServiceList } from "../../models/ServiceData"
import { DEFAULT } from "@ohos/hypium"


@Component
export default struct VIP {
  @StorageProp('topHeight') topHeight: number = 0
@Prop vipServiceList: IVipServiceList = []
  getUnit = (name:string):string=>{
    switch (name){
      case '余额':
        return '元'
      case '优惠券':
        return '张'
      case '会员特权':
        return '项'
      case '会员福利':
        return '个'
      default:
        return ''
    }
  }
  build() {

    Stack() {
      Image($r('app.media.vip_bg')).width(328).height('100%').objectFit(ImageFit.Fill)
      Column({space:14}) {
        Row() {
          Image($r('app.media.crown')).width(18).height(18).objectFit(ImageFit.Fill)
          Text("开通谷粒卡享特权").fontSize(16).fontColor($r('app.color.white')).margin({
            left:8,
            right:52
          })
          Image($r('app.media.vip')).width(42).height(19).objectFit(ImageFit.Fill)
        }
        Row({space:32}){
          ForEach(this.vipServiceList,(vip:IVipServiceItem)=>{
            Column({space:6}){
              Text(vip.name).fontColor($r('app.color.white')).fontSize(12)
              Text(){
                Span(vip.content+'').fontSize(16).fontWeight(700)
                Span(this.getUnit(vip.name)).fontSize(10)
              }.fontColor($r('app.color.white'))
            }
          })
        }
      }.height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(99)
    .margin({ top: 49 + this.topHeight })
  }
}