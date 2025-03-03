import { getHomeDataApi } from "../api/home"
import { PADDING, SHADOW_RADIUS } from "../constants/size"
import { BannerListDataSource, IBannerList, INavList, IPlanList, ITileList } from "../models/HomeData"
import NavList from "../views/Home/NavList"
import PlanList from "../views/Home/PlanList"
import RoomRecommend from "../views/Home/RoomRecommend"
import SearchBar from "../views/Home/SearchBar"
import SwiperLayout from '../views/Home/SwiperLayout'
import TileList from "../views/Home/TileList"
@Preview
@Component
export default struct Home {
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string =  'rgba(255, 255, 255, 1)'
  scrollY:number = 0;
  handleScroll: ScrollOnScrollCallback = (xOffset: number,yOffset: number)=>{
    this.scrollY+=yOffset
    console.log('y轴'+this.scrollY)
    this.calcColor()
  }
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = []
  @State tileList: ITileList = []
  @State planList:IPlanList = []
  @State adPicture: string = '';
  getHomeData = async () => {
    const result = await getHomeDataApi()
    // console.log(JSON.stringify(result))
    // let bannerList = result.bannerList
    // let bannerList: IBannerList = [
    //   {
    //     "id": 1,
    //     "name": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   }
    // ]
    this.bannerList.setList(result.bannerList);
    // this.navList = [
    //   {
    //     "id": 1,
    //     "title": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 2,
    //     "title": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 3,
    //     "title": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 4,
    //     "title": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 5,
    //     "title": "banner1",
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   }
    // ]
    this.navList = result.navList
    // this.tileList = [
    //   {
    //     "id": 1,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0",
    //     "title": "string",
    //     "sub_title": "string"
    //
    //   },
    //   {
    //     "id": 2,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0",
    //     "title": "string",
    //     "sub_title": "string"
    //
    //   }
    // ]
    this.tileList  = result.tileList
    // this.planList= [
    //   {
    //     "id": 1,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 2,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 3,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 4,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   },
    //   {
    //     "id": 5,
    //     "imageURL": "https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    //   }
    // ]
    this.planList= result.planList
      // this.adPicture ="https://cdn.nlark.com/yuque/0/2024/png/305747/1705479951529-6cf6bd5b-00bc-4011-a80d-baa6f72f959c.png?x-oss-process=image%2Fwatermark%2Ctype_d3F5LW1pY3JvaGVp%2Csize_19%2Ctext_5bCa56GF6LC3%2Ccolor_FFFFFF%2Cshadow_50%2Ct_80%2Cg_se%2Cx_10%2Cy_10%2Fformat%2Cwebp%2Fresize%2Cw_659%2Climit_0"
    this.adPicture = result.adPicture
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY < 10) {
      this.fontColor = 'rgba(255, 255, 255, 1)'
      this.bgColor = 'rgba(255, 255, 255, 0)'
    } else if(this.scrollY<=300){
      const  colorOpacity = (this.scrollY-10)/(300-10)
      this.bgColor = `rgba(255, 255, 255, ${colorOpacity})`
      this.fontColor = `rgba(0, 0, 0,${colorOpacity})`
    }else {
      this.fontColor = 'rgb(0, 0, 0)'
      this.bgColor = 'rgb(255, 255, 255)'
    }
    console.log( this.fontColor,this.bgColor)
  }
  build() {
    Stack() {
      Scroll() {
          Column() {
            // 轮播图组件 使用prop通信
            SwiperLayout({ bannerList: this.bannerList })
            Column() {
              NavList({ navList: this.navList })
              TileList({ tileList: this.tileList })
              PlanList({ planList: this.planList })
              Image(this.adPicture)
                .width('100%')
                .height(60)
                .objectFit(ImageFit.Fill)
                .margin({ top: 10 })
                .shadow({
                  offsetX: 0,
                  offsetY: 0,
                  radius: SHADOW_RADIUS,
                  color: 'rgba(0,0,0,0.14)'
                })
            }.margin({ left: PADDING, right: PADDING })

            RoomRecommend()
          }
          .width('100%').justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .onDidScroll(this.handleScroll)
      SearchBar({fontColor:this.fontColor,bgColor: this.bgColor})
    }.width('100%').height('100%').align(Alignment.TopStart)
  }
}