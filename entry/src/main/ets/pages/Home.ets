import { getHomeDataApi } from "../api/home"
import { BannerListDataSource, IBannerList } from "../models/HomeData"
import SwiperLayout from '../views/Home/SwiperLayout'

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  getHomeData = async () => {
    const result = await getHomeDataApi()
    console.log(JSON.stringify(result))
    result.bannerList = [
      {
        "id": 1,
        "name": "banner1",
        "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
      }
    ]
    this.bannerList.setList(result.bannerList);
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Column() {
        // 轮播图组件 使用prop通信
        SwiperLayout({bannerList:this.bannerList})
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}