import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"


@Component
export default struct VIP {
  @StorageProp('topHeight') topHeight: number = 0

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
          Column({space:6}){
            Text('余额').fontColor($r('app.color.white')).fontSize(12)
            Text(){
              Span('0').fontSize(16).fontWeight(700)
              Span('元').fontSize(10)
            }.fontColor($r('app.color.white'))
          }
          Column({space:6}){
            Text('优惠券').fontColor($r('app.color.white')).fontSize(12)
            Text(){
              Span('4').fontSize(16).fontWeight(700)
              Span('张').fontSize(10)
            }.fontColor($r('app.color.white'))
          }
          Column({space:6}){
            Text('会员特权').fontColor($r('app.color.white')).fontSize(12)
            Text(){
              Span('7').fontSize(16).fontWeight(700)
              Span('项').fontSize(10)
            }.fontColor($r('app.color.white'))
          }
          Column({space:6}){
            Text('会员福利').fontColor($r('app.color.white')).fontSize(12)
            Text(){
              Span('21').fontSize(16).fontWeight(700)
              Span('个').fontSize(10)
            }.fontColor($r('app.color.white'))
          }
        }
      }.height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(99)
    .margin({ top: 49 + this.topHeight })
  }
}