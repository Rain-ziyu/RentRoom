import { getServiceDataApi } from '../api/service'
import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import { IColor } from '../models/HomeData'
import {
  ICleaningServiceInfoList,
  IHomeServiceList, INewcomerZone, IServiceActivity, IVipServiceList } from '../models/ServiceData'
import Bg from '../views/Service/Bg'
import DomesticService from '../views/Service/DomesticService'
import NavBar from '../views/Service/NavBar'
import ServiceCalendar from '../views/Service/ServiceCalendar'
import ServiceClean from '../views/Service/ServiceClean'
import VIP from '../views/Service/VIP'

@Component
export default struct Service {
  @State cleaningServiceInfo: ICleaningServiceInfoList = []
  @State newcomerZone: INewcomerZone = {
    img: ''
  }
  @State serviceActivity: IServiceActivity = {
    name: '',
    img: '',
    title: '',
    subTitle: ''
  }
  @State homeServiceList: IHomeServiceList = []
  @State vipServiceList: IVipServiceList = []

  @Builder
  navBuilder($$:IColor) {
    NavBar({fontColor:$$.fontColor})
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP({vipServiceList:this.vipServiceList})
        DomesticService({homeServiceList:this.homeServiceList})
        ServiceCalendar({serviceActivity:this.serviceActivity})
        ServiceClean({newcomerZone:this.newcomerZone,cleaningServiceInfo:this.cleaningServiceInfo})
      }.width('100%').padding({ left: PADDING, right: PADDING })
    }.width('100%').alignContent(Alignment.TopStart).backgroundColor($r('app.color.bg_gray_second'))
  }

  getServiceData = async () => {
    const serviceData = await getServiceDataApi()
    this.vipServiceList = serviceData.vipServiceList
    this.homeServiceList = serviceData.homeServiceList
    this.serviceActivity = serviceData.serviceActivity
    this.newcomerZone = serviceData.newcomerZone
    this.cleaningServiceInfo = serviceData.cleaningServiceInfo
  }

  aboutToAppear(): void {
    this.getServiceData()
  }

  build() {
    Row() {
      ScrollContainer({
        navBuilderParam: this.navBuilder,
        contentBuilderParam: () => {
          this.contentBuilder()
        }
      })
    }
  }
}