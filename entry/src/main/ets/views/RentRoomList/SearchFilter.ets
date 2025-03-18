import { PADDING } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'

@Component
export default struct SearchFilter {
  @State isSearchArea: boolean = false
  @State searchTextList: string[] = ['位置', '支付方式', '租金', '排序']
  @State currentSearchText :string = ''
  // 设置显示搜索区域
  showSearchArea = (text:string) => {
    if(text === this.currentSearchText){
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
@Builder positionBuilder(){
    Text('位置')
}
  @Builder paymentBuilder(){
    Text('支付方式')
  }
  @Builder rentPriceBuilder(){
    Text('租金')
  }@Builder orderBuilder(){
  Text('排序')
}

  build() {
    Column() {
      // 四个搜索文件
      Row() {
        ForEach(this.searchTextList, (text: string) => {
          Row({ space: 6 }) {
            Text(text).fontSize(14).fontColor('#333333')
            Image(this.currentSearchText===text?$r('app.media.arrow_down_3_active'):$r('app.media.arrow_down_3')).width(this.currentSearchText===text?15:6).height(this.currentSearchText===text?10:3)
          }.onClick(()=>this.showSearchArea(text))
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
          if (this.currentSearchText ==='位置') {
            this.positionBuilder()
          }else if (this.currentSearchText ==='支付方式'){
            this.paymentBuilder()
          }else if (this.currentSearchText==='租金'){
            this.rentPriceBuilder()
          }else if(this.currentSearchText ==='排序'){
            this.orderBuilder()
          }

        }.width('100%').height(300).backgroundColor($r('app.color.white'))

        //遮罩层
        Column() {

        }.width('100%').layoutWeight(1).backgroundColor('rgba(0,0,0,0.7)')
        .onClick(this.hideSearchArea)
      }
    }.width('100%').height(this.isSearchArea ? '100%' : 88).padding({ top: 44 })
  }
}