import { getHomeDataApi, getRoomRecommendListApi } from '../../api/home'
import { BORDER_RADIUS, PADDING, PADDING_S } from '../../constants/size'
import type {
  BannerListDataSource,
  IBannerItem,
  IBannerList,
  INavList,
  IRoomRecommendItem,
  IRoomRecommendList,
  ITagItem,
  ITileItem,
  ITileList
} from '../../models/HomeData'
import { RowModifier } from '@kit.ArkUI'

@Component
export default struct RoomRecommend {
  @State roomRecommendList: IRoomRecommendList = []

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getRoomRecommendData()
  }

  getRoomRecommendData = async () => {
    this.roomRecommendList = await getRoomRecommendListApi()
    // console.log(JSON.stringify(result))
    // let bannerList = result.bannerList
  }

  build() {
    Column() {
      Row() {
        Text() {
          Span('周边房源')
          Span('推荐').fontColor($r('app.color.primary'))
        }.fontSize(16).fontWeight(700).fontColor($r('app.color.black'))

        Row({ space: 6 }) {
          Text('更多推荐').fontSize(10).fontColor($r('app.color.gray_second'))
          Image($r('app.media.arrow_right')).width(4).height(8)
        }

      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: PADDING, right: PADDING })
      .backgroundColor($r('app.color.white'))

      Grid() {
        ForEach(this.roomRecommendList, (room: IRoomRecommendItem) => {
          GridItem() {
            Column() {
              Stack() {
                Image(room.housePicture).width('100%').height('100%').objectFit(ImageFit.Fill)
                  .borderRadius({
                    topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS
                  })
                Image($r('app.media.room_text_bg')).width('100%').height('100%').objectFit(ImageFit.Fill).borderRadius({
                  topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS
                })
                Row({ space: 6 }) {
                  Image($r('app.media.location')).width(12).height(14).objectFit(ImageFit.Fill)
                  Text(room.address).fontSize(10).fontColor($r('app.color.white'))
                }.margin({ left: 8, bottom: 6 })
              }.width('100%').height(120).alignContent(Alignment.BottomStart)

              Column() {
                Row() {
                  Text() {
                    Span(room.rentPriceListing).fontSize(14)
                    Span(room.rentPriceUnit).fontSize(12)
                  }.fontColor('#E03810')

                  Text(room.rentArea + 'm').fontSize(10).fontColor($r('app.color.gray'))
                }.width('100%').justifyContent(FlexAlign.SpaceBetween).height(22)

                Text(room.houseTitle)
                  .fontSize(12)
                  .fontColor($r('app.color.black'))
                  .width('100%')
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
                  .height(18)
                  .maxLines(1)
                  .margin({ top: 2 })
                Row({space:6}){
                ForEach(room.tags.slice(0, 2), (tag: ITagItem,index) => {
                  Text(tag.name).fontSize(10).fontColor(index===1?$r('app.color.gray_text'):$r('app.color.white')).backgroundColor($r('app.color.primary'))
                    .height(16).padding({left:6,right:6})
                    .borderRadius(2)
                }, (tag: ITagItem) => tag.name)}.width('100%').margin({top :6})
              }.width('100%').padding(PADDING_S)
            }.width(160).height(210).borderRadius(BORDER_RADIUS).backgroundColor($r('app.color.white'))
          }
        }, (room: IRoomRecommendItem) => room.id + '')

      }
      .width('100%')
      .height(210 * 4 + 16 * 2 + 8 * 3)
      .backgroundColor($r('app.color.bg_gray'))
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
      .padding(PADDING)
    }
    .width('100%')
    .margin({ top: 12 })
  }
}