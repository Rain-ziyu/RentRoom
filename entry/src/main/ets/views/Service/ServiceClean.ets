import { BORDER_RADIUS_S, PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import {
  ICleaningServiceInfoItem,
  ICleaningServiceInfoList,
  INewcomerZone, IServiceActivity, IVipServiceItem, IVipServiceList } from "../../models/ServiceData"
import { DEFAULT } from "@ohos/hypium"
import { CardRecognition } from "@hms.ai.CardRecognition"
import Card from "../../components/Card/Index"
import getCalendar from "../../util/calendar"


@Component
export default struct ServiceClean {
  @StorageProp('topHeight') topHeight: number = 0
  @Prop newcomerZone: INewcomerZone
  @Prop cleaningServiceInfo: ICleaningServiceInfoList = []
@State currentIndex :number = 0
  @Builder
  contentBuilder() {
    Column() {
      Card() {
        Text() {
          Span('新人').fontColor($r('app.color.black'))
          Span('专区').fontColor($r('app.color.primary'))
        }.fontSize(16).fontWeight(700).alignSelf(ItemAlign.Start)

        Image(this.newcomerZone.img).width('100%').height(90).margin({ top: 8 })
      }

      Card() {
        Text('洁净家') {
        }.fontSize(16).fontWeight(700).alignSelf(ItemAlign.Start).fontColor($r('app.color.black'))

        Row({ space: 8 }) {
          ForEach(this.cleaningServiceInfo, (item: ICleaningServiceInfoItem) => {
           Column({space:8}){
            Image(item.img).width('152').height(115)
            Text(item.title).fontWeight(700).fontSize(14).fontColor($r('app.color.black')).alignSelf(ItemAlign.Start)
            Text(item.subTitle).fontSize(10).fontColor($r('app.color.gray_second')).alignSelf(ItemAlign.Start)
             Row({space:4}){
              Text('到手价').fontSize(10).fontColor($r('app.color.gray_second'))
               Text('￥'+item.priceAfterDiscounts).fontSize(16).fontColor($r('app.color.red_text'))
               Text('￥'+item.originalPrice).fontSize(10).fontColor($r('app.color.gray_second'))
                 .decoration({type:TextDecorationType.LineThrough})

             }.alignSelf(ItemAlign.Start)
           }
          },
            (item: ICleaningServiceInfoItem) =>
            item.title
          )
        }.width('100%')
      }
    }
  }

  @Builder
  tabBarBuilder(title: string, subTitle: string, index: number) {
    Column({ space: 3 }) {
      Text(title).fontSize(this.currentIndex===index?18:14).fontWeight(700).fontColor($r('app.color.black'))
      Text(subTitle).fontSize(12).fontColor($r('app.color.gray_second'))
      if (this.currentIndex===index){
        Row(){

        }.width(20).height(4).backgroundColor("#51BB9E")
      }
    }.justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs() {
      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('会员精选', '专业服务', 0))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('居家保洁', '解放双手', 1))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('深层清洗', '高温蒸洗', 2))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('新居乔迁', '一站搬家', 3))
    }.height(440).onChange((index=>{this.currentIndex=index})).barHeight(70)
  }
}