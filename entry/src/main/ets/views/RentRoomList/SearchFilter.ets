import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoomList'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IGetRentRoomListParams,
  IPaymentType,
  IProvinceItem,
  IProvinceList,
  ISortItem,
  ISortList,
  RentPrice,
  RentPriceList
} from '../../models/RentRoomList'
import globalEmitter from '../../util/emitter'
import { EditableLeftIconType } from '@kit.ArkUI'

@Component
export default struct SearchFilter {
  @State isSearchArea: boolean = false
  @State searchTextList: string[] = ['位置', '支付方式', '租金', '排序']
  @State @Watch('handleSearchTextChange') currentSearchText: string = ''

  handleSearchTextChange(changedPropertyName: string) {
    if (this.currentSearchText === '位置') {
      this.currentProvinceCode = this.preProvinceCode
      this.currentCityCode = this.preCityCode
      this.currentDistrictCode = this.preDistrictCode
      this.getProvinceList()
    } else if (this.currentSearchText === '支付方式') {
      this.currentPaymentWay = this.prePaymentWay
    }else if (this.currentSearchText==='租金'){
      this.currentRentPriceId = this.preRentPriceId
    }
  }

  // 设置显示搜索区域
  showSearchArea = (text: string) => {
    if (text === this.currentSearchText) {
      this.isSearchArea = !this.isSearchArea
      this.currentSearchText = ''
      return
    }
    this.isSearchArea = true
    this.currentSearchText = text
  }
  hideSearchArea = () => {
    this.currentSearchText = ''
    this.isSearchArea = false
  }
  @State currentProvinceCode: string = ''
  @State currentCityCode: string = ''
  @State currentDistrictCode: string = ''
  @State currentDistrictName: string = ''
  @State preProvinceCode: string = ''
  @State preCityCode: string = ''
  @State preDistrictCode: string = ''

  @Builder
  positionBuilder() {
    Row() {
      List() {
        ForEach(this.provinceList, (province: IProvinceItem) => {
          ListItem() {
            Text(province.name)
              .fontSize(12)
              .fontColor(this.currentProvinceCode === province.code ? $r('app.color.primary') : $r('app.color.black'))

          }
          .height(30)
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: PADDING, right: PADDING })
          .onClick(() => {
            this.currentCityCode = ''
            this.currentDistrictCode = ''
            this.getCityList(province.code)
            this.currentProvinceCode = province.code
          })
        }, (province: IProvinceItem) => province.code)
      }.width(120).height('100%').backgroundColor($r('app.color.white')).scrollBar(BarState.Off)

      List() {
        ForEach(this.cityList, (city: ICityItem) => {
          ListItem() {
            Text(city.name)
              .fontSize(12)
              .fontColor(this.currentCityCode === city.code ? $r('app.color.primary') : $r('app.color.black'))
          }
          .height(30)
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: PADDING, right: PADDING })
          .onClick(() => {
            this.currentDistrictCode = ''
            this.getDistrictList(city.code)
            this.currentCityCode = city.code
          })
        }, (city: ICityItem) => city.code)
      }.width(120).height('100%').backgroundColor('#ebebeb').scrollBar(BarState.Off)

      List() {
        ForEach(this.districtList, (district: IDistrictItem) => {
          ListItem() {
            Text(district.name).fontSize(12)
              .fontColor(this.currentDistrictCode === district.code ? $r('app.color.primary') : $r('app.color.black'))
          }
          .height(30)
          .width('100%')
          .align(Alignment.Start)
          .padding({ left: PADDING, right: PADDING })
          .onClick(() => {

            this.currentDistrictCode = district.code

          })
        }, (district: IDistrictItem) => district.code)

      }.width(120).height('100%').backgroundColor('#e6e6e6').scrollBar(BarState.Off)
    }.height(240).width('100%')

    Row({ space: 22 }) {
      Button('重置')
        .buttonStyles(95, '#F0F0F0', $r('app.color.gray_second')).onClick(this.resetLocation)
      Button('查看房源')
        .buttonStyles(211, '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.currentDistrictName =
            this.districtList.find(district => this.currentDistrictCode === district.code)!.name
          this.hideSearchArea()
          this.preProvinceCode = this.currentProvinceCode
          this.preCityCode = this.currentCityCode
          this.preDistrictCode = this.currentDistrictCode
          //   触发搜索房源列表
          globalEmitter.emit('search', {
            provinceCode: this.currentProvinceCode,
            cityCode: this.currentCityCode,
            districtCode: this.currentDistrictCode
          })
        })
    }.height(58).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)

  }

  // 重置地区
  resetLocation = () => {
    this.currentProvinceCode = this.provinceList[0].code;
    this.currentCityCode = '';
    this.currentDistrictCode = '';
    // this.currentDistrictName = ''
    this.getCityList(this.currentProvinceCode)
  }
  @State prePaymentWay: string = ''
  // 重置支付方式
  resetPaymentWay = () => {
    this.currentPaymentWay = ''
  }
  submitPaymentWay = () => {
    this.prePaymentWay = this.currentPaymentWay
    this.hideSearchArea()
    globalEmitter.emit('search', { paymentType: this.prePaymentWay })
  }
  @State paymentWayList: string[] = ['月付', '季付', '半年付', '年付']
  @State currentPaymentWay: string = ''
  @State rentPriceList: RentPriceList = [
    {
      id: 1,
      minRent: '0',
      maxRent: '0',
      text: '不限'
    },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      maxRent: '0',
      text: '10000元以上'
    }
  ]

  @Builder
  paymentBuilder() {
    Row() {
      ForEach(this.paymentWayList, (paymentWay: string) => {
        Text(paymentWay)
          .width(70)
          .height(26)
          .borderRadius(BORDER_RADIUS_S)
          .backgroundColor(this.currentPaymentWay === paymentWay ? '#67C0AB' : $r('app.color.bg_gray'))
          .fontSize(12)
          .fontColor($r('app.color.gray_second'))
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.currentPaymentWay = paymentWay
          })
      }, (paymentWay: string) => paymentWay)

    }.width('100%')
    .padding(PADDING).justifyContent(FlexAlign.SpaceBetween)

    Row({ space: 22 }) {
      Button('重置')
        .buttonStyles(95, '#F0F0F0', $r('app.color.gray_second')).onClick(this.resetPaymentWay)
      Button('查看房源')
        .buttonStyles(211, '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.submitPaymentWay()
        })
    }.height(58).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)

  }

  @State currentRentPriceId: number = -1
  @State preRentPriceId: number = -1
  @State minRent: string = '0'
  @State maxRent: string = '0'
  resetRentPrice = () => {
    this.currentRentPriceId = -1
  }
  submitRentPrice = () => {
    this.preRentPriceId = this.currentRentPriceId
    if (this.currentRentPriceId===-1){
      globalEmitter.emit('search', {  })
      this.hideSearchArea()
      return
    }
    this.minRent = this.rentPriceList[this.currentRentPriceId].minRent
    this.maxRent = this.rentPriceList[this.currentRentPriceId].maxRent
    this.hideSearchArea()
    globalEmitter.emit('search', { minRent: this.minRent, maxRent: this.maxRent })
  }

  @Builder
  rentPriceBuilder() {
    Grid() {
      ForEach(this.rentPriceList, (rentPrice: RentPrice) => {
        GridItem() {
          Text(rentPrice.text)
            .width(94)
            .height(26)
            .borderRadius(BORDER_RADIUS_S)
            .backgroundColor(this.currentRentPriceId === rentPrice.id ? $r('app.color.primary') :
            $r('app.color.bg_gray'))
            .fontSize(12)
            .fontColor($r('app.color.gray_second'))
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.currentRentPriceId = rentPrice.id
            })
        }
      }, (rentPrice: RentPrice) => rentPrice.id + '')

    }
    .width('100%')
    .height(136)
    .padding(PADDING)
    .columnsTemplate('1fr 1fr 1fr')
    .rowsGap(8)

    Row({ space: 22 }) {
      Button('重置')
        .buttonStyles(95, '#F0F0F0', $r('app.color.gray_second')).onClick(this.resetRentPrice)
      Button('查看房源')
        .buttonStyles(211, '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.submitRentPrice()
        })
    }.height(58).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)

  }
@State sortList :ISortList = [
  {
    id: 1,
    icon: $r('app.media.sort'),
    text: '综合排序',
    orderBy: '',
    orderType: ''
  },
  {
    id: 2,
    icon: $r('app.media.rent'),
    text: '价格从低到高',
    orderBy: 'price',
    orderType: 'asc'
  },
  {
    id: 3,
    icon: $r('app.media.rent'),
    text: '价格从高到低',
    orderBy: 'price',
    orderType: 'desc'
  },
  {
    id: 4,
    icon: $r('app.media.area'),
    text: '面积从大到小',
    orderBy: 'area',
    orderType: 'desc'
  },
  {
    id: 5,
    icon: $r('app.media.area'),
    text: '面积从小到大',
    orderBy: 'area',
    orderType: 'asc'
  },
]
@State sortText:string = ''
  @Builder
  orderBuilder() {
    Column(){
      ForEach(this.sortList,(sort:ISortItem)=>{
        Row({space:8}){
          Image(sort.icon).width(16).height(16).fillColor($r('app.color.black'))
          Text(sort.text).fontSize(12).fontColor(this.sortText===sort.text?'#67C0AB':$r('app.color.gray_second'))
        }.height(34).onClick(()=>{
          this.sortText = sort.text
          globalEmitter.emit('search',{
            orderBy:sort.orderBy,
            orderType:sort.orderType
          })
        })
      })
    }.width('100%').alignItems(HorizontalAlign.Start).padding({left:32,bottom:16})
  }

  getSearchText = (text: string) => {
    if (text === '位置') {
      return this.currentDistrictName || text
    } else if (text === '支付方式') {
      return this.prePaymentWay || text
    }else if (text === '租金') {
      return this.preRentPriceId===-1? text:this.rentPriceList[this.preRentPriceId].text
    }else if (text === '排序') {
      return this.sortText||text
    }
    return text
  }
  getSearchTextColor = (text: string) => {
    if (text === '位置') {
      return this.currentDistrictName ? $r('app.color.primary') : '#333333'
    } else if (text === '支付方式') {
      return this.prePaymentWay ? $r('app.color.primary') : '#333333'
    }  else if (text === '租金') {
      return this.preRentPriceId===-1 ?'#333333': $r('app.color.primary')
    }else if (text === '排序') {
      return this.sortText?$r('app.color.primary') : '#333333'
    }
    else {
      return text
    }
  }

  build() {
    Column() {
      // 四个搜索
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: 6 }) {
            Text(this.getSearchText(text))
              .fontSize(14)
              .fontColor(this.getSearchTextColor(text))
              .constraintSize({ maxWidth: 56 })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image(this.currentSearchText === text ? $r('app.media.arrow_down_3_active') : $r('app.media.arrow_down_3'))
              .width(this.currentSearchText === text ? 15 : 6)
              .height(this.currentSearchText === text ? 10 : 3)
          }.onClick(() => this.showSearchArea(text))
        }, (text: string) => text)

      }
      .width('100%')
      .height(44)
      .padding({ left: PADDING, right: PADDING })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.white'))

      if (this.isSearchArea) {
        // 搜索区域
        Column() {
          if (this.currentSearchText === '位置') {
            this.positionBuilder()
          } else if (this.currentSearchText === '支付方式') {
            this.paymentBuilder()
          } else if (this.currentSearchText === '租金') {
            this.rentPriceBuilder()
          } else if (this.currentSearchText === '排序') {
            this.orderBuilder()
          }

        }.width('100%').backgroundColor($r('app.color.white'))

        //遮罩层
        Column() {

        }.width('100%').layoutWeight(1).backgroundColor('rgba(0,0,0,0.7)')
        .onClick(this.hideSearchArea)
      }
    }.width('100%').height(this.isSearchArea ? '100%' : 88).padding({ top: 44 })
  }

  @State provinceList: IProvinceList = []
  //   获取省份数据

  getProvinceList = async () => {
    this.provinceList = await getProvinceListApi()
    this.currentProvinceCode = this.currentProvinceCode || this.provinceList[0].code
    this.getCityList(this.currentProvinceCode)
  }
  @State cityList: ICityList = []
  //   获取城市数据

  getCityList = async (provinceCode: string) => {
    this.cityList = await getCityListApi(provinceCode)
    this.currentCityCode = this.currentCityCode || this.cityList[0].code
    this.getDistrictList(this.currentCityCode)
  }
  @State districtList: IDistrictList = []
  //   获取区数据

  getDistrictList = async (cityCode: string) => {

    this.districtList = await getDistrictListApi(cityCode)
    this.currentDistrictCode = this.currentDistrictCode || this.districtList[0].code
  }
}

@Extend(Button)
function buttonStyles(width: number, bgColor: string | Resource, fontColor: string | Resource) {
  .type(ButtonType.Normal)
  .width(width)
  .height(26)
  .borderRadius(BORDER_RADIUS_S)
  .fontSize(12)
  .backgroundColor(bgColor)
  .fontColor(fontColor)
}