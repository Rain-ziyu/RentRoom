import router from '@ohos.router'
import { getRoomDetailApi } from '../../api/rentRoomDetail'

import { IDiscountsList,
  IDistanceInfo,
  IHouseholdList,
  IMetaInfoList,
  IRentInfoList,
  IRentRoomDetail, IRentRoomParam, IRoomName,
  ISupportList } from '../../models/RentRoomData'
import NavBar from '../../components/NavBar/Index'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import ScrollContainer from '../../components/ScrollContainer/Index'
import RentPrice from '../../views/RentRoomDetail/RentPrice'
import rvp, { sm } from '../../util/responsive'
import DiscountsList from '../../views/RentRoomDetail/DiscountsList'
import MetaInfo from '../../views/RentRoomDetail/MetaInfo'
import { ITagList } from '../../models/HomeData'
import TagList from '../../views/RentRoomDetail/TagList'
import RentInfo from '../../views/RentRoomDetail/RentInfo'
import HouseholdItem from '../../views/RentRoomDetail/HouseholdItem'
import SupportList from '../../views/RentRoomDetail/SupportList'
import Book from '../../views/RentRoomDetail/Book'
import BookInfo from '../../views/RentRoomDetail/BookInfo'

@Entry
@Component
struct RentRoomDetail {
  @State room: IRentRoomDetail = {
    housePicture: [],
    distance_info: {
      "distance": '',
      "line": '',
      "name": ''
    },
    rentTerm: {
      "checkInTime": '',
      "term": '',
      "kitchen": '',
      "lift": '',
      "seeTime": '',
      "year": '',
      "renovation": '',
      "grounding": '',
      "heating": '',
      "green": '',
      "protection": '',
      "house": '',
    },

    metaInfo: [],
    discounts: [],
    householdItem: [],
    support: [],
    rentInfo: [],
    id: '',
    tags: [],
    houseTitle: '',
    address: '',
    rentPriceUnit: '',
    rentPriceUnitListing: '',
    rentArea: '',
    rentPriceListing: ''
  }
  @State roomNameList: IRoomName[] = []
  @State roomPictureList: string[] = []
  @State currentRoomIndex: number = 0
  @State discountsList: IDiscountsList = []
  @State metaInfoList: IMetaInfoList = []
  @State distanceInfo: IDistanceInfo = {
    distance: '',
    line: '',
    name: ''
  }
  @State tagList: ITagList = []
  @State rentInfoList: IRentInfoList = []
  @State householdList: IHouseholdList = []
  @State supportList: ISupportList = []
  @StorageProp('topHeight') topHeight: number = 0
  picScroller: Scroller = new Scroller()
  @State show: boolean = false
  aboutToAppear(): void {
    this.getRoomDetail()
  }

  getRoomDetail = async () => {
    const params: IRentRoomParam = { "id": 'BJ1827549448671068160' }
    if (router.getParams()) {
      const params = router.getParams() as IRentRoomParam
    }
    this.room = await getRoomDetailApi(params.id || 'BJ1827549448671068160')
    console.log(JSON.stringify(this.room))
    this.roomNameList = this.room.housePicture.map(item => {
      const roomName: IRoomName = {
        spaceName: item.spaceName,
        total: item.picList.length
      }
      return roomName
    })
    this.discountsList = this.room.discounts
    this.metaInfoList = this.room.metaInfo
    this.distanceInfo = this.room.distance_info
    this.tagList = this.room.tags
    this.rentInfoList = this.room.rentInfo
    this.householdList = this.room.householdItem
    this.supportList = this.room.support
    this.roomPictureList = this.room.housePicture.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])
  }

  @Builder
  contentBuilder() {
    Column() {
      List({ space: 16 }) {
        ForEach(this.roomNameList, (roomName: IRoomName, index) => {
          ListItem() {
            Column({ space: 4 }) {
              Text(`${roomName.spaceName}(${roomName.total})`)
                .fontSize(14)
                .fontColor(this.currentRoomIndex === index ? $r('app.color.black') : $r('app.color.gray_second'))
              if (this.currentRoomIndex === index) {
                Row() {
                }.width(16).height(2).backgroundColor($r('app.color.primary'))
              }
            }
          }.onClick(() => {
            this.currentRoomIndex = index;
            let sum = 0
            for (let i = 0; i < index; i++) {
              sum += this.room.housePicture[i].picList.length
            }

            this.picScroller.scrollToIndex(sum, true)
          })
        }, (roomName: IRoomName) => roomName.spaceName)
      }
      .width('100%')
      .height(58)
      .padding({ left: PADDING, right: PADDING, bottom: PADDING })
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .margin({ top: 44 + this.topHeight })

      List({ scroller: this.picScroller }) {

        ForEach(this.roomPictureList, (pic: string) => {
          ListItem() {
            Image(pic).width(318).height('100%').objectFit(ImageFit.Fill)
          }.margin({ left: 16 })
        })
        ListItem() {
        }.width(16)
      }
      .width('100%')
      .height(208)
      .padding({ bottom: PADDING })
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      // 用于监听滚动事件
      .onScrollIndex((startIndex, endIndex) => {
        console.log(startIndex + '')
        let res: number = 0
        for (let i = 0; i < startIndex + 1; ) {
          res += 1
          if (res >= this.roomNameList.length) {
            break
          } else {
            i += this.roomNameList[res].total
          }
        }
        this.currentRoomIndex = res - 1
      })

      Column() {
        RentPrice({ rentPriceListing: this.room.rentPriceUnitListing, rentPriceUnit: this.room.rentPriceUnit })
        DiscountsList({ discountsList: this.discountsList })
        MetaInfo({ metaInfoList: this.metaInfoList, distanceInfo: this.distanceInfo })
        TagList({ tagList: this.tagList })
        RentInfo({ rentInfoList: this.rentInfoList })
        HouseholdItem({ householdList: this.householdList })
        SupportList({ supportList: this.supportList })
        Button('查看全部内容')
          .type(ButtonType.Normal)
          .width('100%')
          .height(rvp(44))
          .fontSize(sm())
          .fontColor('#ABA9AC')
          .margin({ top: rvp(25) })
          .backgroundColor($r('app.color.white'))
          .border({ width: 1, color: '#F5F5F5', radius: rvp(BORDER_RADIUS_S) })
      }.padding({ left: rvp(PADDING), right: rvp(PADDING) })
    }.backgroundColor($r('app.color.white'))
  }

  @Builder
  navbarBuilder() {
    NavBar({ title: this.room.houseTitle })
  }

  build() {
    Stack() {

      ScrollContainer({
        navBuilderParam: () => {
          this.navbarBuilder()
        },
        contentBuilderParam: () => {
          this.contentBuilder()
        }
      })
      Book({show:$show})
      BookInfo({show:$show})
    }.height('100%').alignContent(Alignment.Bottom)
  }
}