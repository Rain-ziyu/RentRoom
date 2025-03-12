import { BORDER_RADIUS_S, PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import { IServiceActivity, IVipServiceItem, IVipServiceList } from "../../models/ServiceData"
import { DEFAULT } from "@ohos/hypium"
import { CardRecognition } from "@hms.ai.CardRecognition"
import Card from "../../components/Card/Index"
import getCalendar from "../../util/calendar"


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

    Column() {
      Card({ cardPadding: 0 }) {
        Row() {
          Text('服务日历').fontSize(16).fontColor($r('app.color.black')).fontWeight(700)
          Row({ space: 10 }) {
            Text('全部服务').fontSize(12).fontColor($r('app.color.gray'))
            Image($r('app.media.arrow_right')).width(4).height(9).fillColor($r('app.color.gray'))
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ left: 8 })

        Row() {
          ForEach(getCalendar(), (month: string, index) => {
            if (index === 2) {
              Text() {
                Span(month).fontSize(16).fontColor($r('app.color.black')).fontWeight(700)
                Span('月').fontSize(12).fontColor($r('app.color.gray_second'))
              }
              .backgroundColor('#CDFFD9')
              .width(46)
              .height(32)
              .textAlign(TextAlign.Center)
              .borderRadius(4)
            } else {
              Text() {
                Span(month).fontSize(16).fontColor($r('app.color.black')).fontWeight(700)
                Span('月').fontSize(12).fontColor($r('app.color.gray_second'))
              }
            }
          }, (month: string) => month)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ left: 8, right: 8, top: 16 })

        Column({ space: 8 }) {
          Text(this.serviceActivity.name).fontSize(14).fontColor($r('app.color.black')).fontWeight(700)
          Row() {
            Image(this.serviceActivity.img).height(100).width(100).borderRadius(BORDER_RADIUS_S)
            Column() {
              Text(this.serviceActivity.title).fontSize(14).fontColor($r('app.color.black'))
              Text(this.serviceActivity.subTitle).fontSize(12).fontColor($r('app.color.black')).margin({
                top
                : 8
              })
              Text('立即参与')
                .alignSelf(ItemAlign.End)
                .margin({ top: 22 })
                .backgroundColor('#CDFFD9')
                .borderRadius(BORDER_RADIUS_S)
                .fontColor('#1F632F')
                .padding({
                  left: 10,
                  right: 10,
                  bottom: 6,
                  top
                  : 6
                })
            }.height(100).padding(8).alignItems(HorizontalAlign.Start).layoutWeight(1)
          }
        }
        .width('100%')
        .height(140)
        .linearGradient({
          angle: 205,
          colors: [['#D0FFDB', 0], ['#ffffff', 0.3]]
        })
        .margin({ top: 18 })
        .alignItems(HorizontalAlign.Start)
        .padding(8)
      }

    }.width('100%').margin({ top: 8 })
  }
}