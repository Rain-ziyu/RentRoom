import router from '@ohos.router'
import { getRoomDetailApi } from '../../api/rentRoomDetail'

import { IRentRoomDetail, IRentRoomParam, IRoomName } from '../../models/RentRoomData'
import NavBar from '../../components/NavBar/Index'
import { PADDING } from '../../constants/size'
import ScrollContainer from '../../components/ScrollContainer/Index'

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
    }
  ,
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
    rentPriceListing: '',
    rentArea: ''
  }
  @State roomNameList: IRoomName[] = []
  @State roomPictureList: string[] = []
  @State currentRoomIndex: number = 0
  @StorageProp('topHeight') topHeight: number = 0
  picScroller: Scroller = new Scroller()

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
    this.roomPictureList = this.room.housePicture.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])
  }

  @Builder
  contentBuilder() {
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
  }

  @Builder
  navbarBuilder() {
    NavBar({ title: this.room.houseTitle })
  }

  build() {
    Column() {

      ScrollContainer({
        navBuilderParam: () => {
          this.navbarBuilder()
        },
        contentBuilderParam: () => {
          this.contentBuilder()
        }
      })
    }.height('100%').width('100%')
  }
}