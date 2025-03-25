import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoomList'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList
} from '../../models/RentRoomList'
import globalEmitter from '../../util/emitter'

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

          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
          .onClick(()=>{
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
          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
          .onClick(()=>{
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
          }.height(30).width('100%').align(Alignment.Start).padding({ left: PADDING, right: PADDING })
                   .onClick(()=>{

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
        .onClick(()=>{
          this.currentDistrictName = this.districtList.find(district=>this.currentDistrictCode===district.code)!.name
          this.hideSearchArea()
          this.preProvinceCode = this.currentProvinceCode
          this.preCityCode = this.currentCityCode
          this.preDistrictCode = this.currentDistrictCode
        //   触发搜索房源列表
          globalEmitter.emit('search',{
            provinceCode : this.currentProvinceCode,
            cityCode:this.currentCityCode,
            districtCode:this.currentDistrictCode
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
    this.getCityList(this.currentProvinceCode )
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
getSearchText = (text:string)=>{
    if(text==='位置'){
      return this.currentDistrictName ||text
    }else {
      return text
    }
}
  getSearchTextColor = (text:string)=>{
    if(text==='位置'){
      return this.currentDistrictName?$r('app.color.primary'):'#333333'
    }else {
      return text
    }
  }
  build() {
    Column() {
      // 四个搜索
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: 6 }) {
            Text(this.getSearchText(text)).fontSize(14).fontColor(this.getSearchTextColor(text))
              .constraintSize({maxWidth:56}).maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})
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
    this.currentProvinceCode = this.currentProvinceCode||this.provinceList[0].code
    this.getCityList( this.currentProvinceCode)
  }
  @State cityList: ICityList = []
  //   获取城市数据

  getCityList = async (provinceCode: string) => {
    this.cityList = await getCityListApi(provinceCode)
    this.currentCityCode =  this.currentCityCode||this.cityList[0].code
    this.getDistrictList(this.currentCityCode)
  }
  @State districtList: IDistrictList = []
  //   获取区数据

  getDistrictList = async (cityCode: string) => {

    this.districtList = await getDistrictListApi(cityCode)
    this.currentDistrictCode =this.currentDistrictCode|| this.districtList[0].code
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