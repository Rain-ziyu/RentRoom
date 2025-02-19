import { getHomeDataApi } from "../api/home"
import { PADDING } from "../constants/size"
import { BannerListDataSource, IBannerList, INavList } from "../models/HomeData"
import NavList from "../views/Home/NavList"
import SearchBar from "../views/Home/SearchBar"
import SwiperLayout from '../views/Home/SwiperLayout'

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = []
  getHomeData = async () => {
    // const result = await getHomeDataApi()
    // console.log(JSON.stringify(result))
    // let bannerList = result.bannerList
    let bannerList: IBannerList = [
      {
        "id": 1,
        "name": "banner1",
        "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
      }
    ]
    this.bannerList.setList(bannerList);
    this.navList = [
      {
        "id": 1,
        "title": "banner1",
        "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
      }
    ]
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Stack() {
        Column() {
          // 轮播图组件 使用prop通信
          SwiperLayout({ bannerList: this.bannerList })
          Column(){
            NavList({navList: this.navList})
          }.margin({left:PADDING,right:PADDING})

        }
        .width('100%')
        SearchBar()
      }.width('100%').alignContent(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}