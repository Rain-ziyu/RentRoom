import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoomList'
import { PADDING } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList
} from '../../models/RentRoomList'

@Component
export default struct SearchFilter {
  @State isSearchArea: boolean = false
  @State searchTextList: string[] = ['位置', '支付方式', '租金', '排序']
  @State @Watch('handleSearchTextChange') currentSearchText: string = ''

  handleSearchTextChange(changedPropertyName: string) {
    if (this.currentSearchText === '位置') {
      this.getProvinceList()
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

  @Builder
  positionBuilder() {
    Row() {
      List() {
        ForEach(this.provinceList, (province: IProvinceItem) => {
          ListItem() {
            Text(province.name)
              .fontSize(12)
              .fontColor(this.currentProvinceCode === province.code ? $r('app.color.primary') : $r('app.color.black'))

          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
          .onClick(()=>{
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
          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
          .onClick(()=>{
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
          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
                   .onClick(()=>{

            this.currentDistrictCode = district.code
          })
        }, (district: IDistrictItem) => district.code)

      }.width(120).height('100%').backgroundColor('#e6e6e6').scrollBar(BarState.Off)
    }.height(240).width('100%')
  }

  @Builder
  paymentBuilder() {
    Text('支付方式')
  }

  @Builder
  rentPriceBuilder() {
    Text('租金')
  }

  @Builder
  orderBuilder() {
    Text('排序')
  }

  build() {
    Column() {
      // 四个搜索文件
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: 6 }) {
            Text(text).fontSize(14).fontColor('#333333')
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
    this.currentProvinceCode = this.provinceList[0].code
    this.getCityList(this.provinceList[0].code)
  }
  @State cityList: ICityList = []
  //   获取城市数据

  getCityList = async (provinceCode: string) => {
    this.cityList = await getCityListApi(provinceCode)
    this.currentCityCode = this.cityList[0].code
    this.getDistrictList(this.cityList[0].code)
  }
  @State districtList: IDistrictList = []
  //   获取区数据

  getDistrictList = async (cityCode: string) => {

    this.districtList = await getDistrictListApi(cityCode)
    this.currentDistrictCode = this.districtList[0].code
  }
}