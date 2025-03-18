import { BORDER_RADIUS, PADDING, PADDING_S } from '../../constants/size'
import type {
  BannerListDataSource,
  IBannerItem,
  IBannerList,
  INavItem,
  INavList,
  ITagItem
} from '../../models/HomeData'
import { searchRoomListApi } from '../../api/rentRoomList'
import { IGetRentRoomListParams, IRentRoomItem, IRentRoomList, RentRoomListDataSource } from '../../models/RentRoomList'
import { Event } from '@kit.ArkTS'
import { faceDetector } from '@kit.CoreVisionKit'

@Component
export default struct RoomList {
  @State roomList: IRentRoomList = []
  @State total: number = 0
  @State rentRoomList: RentRoomListDataSource = new RentRoomListDataSource([])
  @State searchOptions: IGetRentRoomListParams = {
    page: 1,
    limit: 10
  }
  @StorageProp('windowsHeight') windowsHeight: number = 713;
  @StorageProp('topHeight') topHeight: number = 0;
  @State endStatus: boolean = false

  async searchRoomList() {
    const res = await searchRoomListApi(this.searchOptions)
    this.roomList = res.records
    this.total = res.total
    if (this.searchOptions.page === 1) {
      this.rentRoomList.reloadDataList(this.roomList)
    } else {
      this.rentRoomList.pushDataList(this.roomList)
    }
  }

  loadMore() {
    if (this.total <= this.rentRoomList.totalCount()) {
      this.endStatus = true
      return
    }
    this.searchOptions.page++
    this.searchRoomList()
  }

  aboutToAppear(): void {
    this.searchRoomList()
  }

  @Builder
  footBuilder() {
    Row({ space: 10 }) {
      if (this.endStatus) {
        Text('没有更多了').fontSize(12).fontColor($r('app.color.gray_text')).margin({ top: 6 })
      } else {
        Refresh({ refreshing: true })
        Text('加载数据中...').fontSize(12).fontColor($r('app.color.gray_text')).margin({ top: 6 })
      }
    }.width('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    WaterFlow({ footer: this.footBuilder }) {
      FlowItem() {
      }.height(8)

      FlowItem() {
      }.height(8)

      LazyForEach(this.rentRoomList, (room: IRentRoomItem) => {
        FlowItem() {
          Column() {
            if (room.activity) {

            } else {
              Stack() {
                Image(room.housePicture).width('100%').height('100%').objectFit(ImageFit.Fill)
                  .borderRadius({
                    topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS
                  })
                Image($r('app.media.room_text_bg'))
                  .width('100%')
                  .height('100%')
                  .objectFit(ImageFit.Fill)
                  .borderRadius({
                    topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS
                  })

                Row({ space: 6 }) {
                  Image($r('app.media.location')).width(12).height(14).objectFit(ImageFit.Fill)
                  Text(room.address).fontSize(10).fontColor($r('app.color.white'))
                }.margin({ left: 8, bottom: 6 })
              }.width('100%').height(120).alignContent(Alignment.BottomStart)
            }
            Column() {
              if (room.activity) {
                Row() {
                  Image(room.activity?.icon).height(26).width(26)
                  Text(room.activity?.title).fontSize(14).fontWeight(700).fontColor($r('app.color.black'))

                }

                Text(Reflect.get(room.activity, '#Text'))
                  .fontSize(10)
                  .fontWeight(700)
                  .fontColor(room.activity.textColor)
                  .backgroundColor(room.activity.textBackGroundColor)
                  .padding({
                    left: 8,
                    right: 8,
                    top: 4,
                    bottom: 4
                  })
                  .borderRadius(21)
                Image(room.housePicture)
                  .width(140)
                  .height(165)
                  .objectFit(ImageFit.Fill)
                  .borderRadius(BORDER_RADIUS)
                  .margin({ top: 8, bottom: 10 })
              }
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
              Row({ space: 6 }) {
                ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
                  Text(tag.name)
                    .fontSize(10)
                    .fontColor(index === 1 ? $r('app.color.gray_text') : $r('app.color.white'))
                    .backgroundColor($r('app.color.primary'))
                    .height(16)
                    .padding({ left: 6, right: 6 })
                    .borderRadius(2)
                }, (tag: ITagItem) => tag.name)
              }.width('100%').margin({ top: 6 })
            }.width('100%').padding(PADDING_S)
          }.width('100%').height('100%').borderRadius(BORDER_RADIUS).backgroundColor($r('app.color.white'))

        }.width(160).height(room.activity ? 320 : 210)
      }, (item: IRentRoomItem) =>
      item.id
      )
    }
    .onReachStart(() => {
      this.searchRoomList()
    })
    .onReachEnd(() => {
      this.loadMore()
    })
    .width('100%')
    .height('100%')
    .rowsGap(8)
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .padding({ top:88,left: PADDING, right: PADDING })
    .backgroundColor($r('app.color.bg_gray'))
  }
}