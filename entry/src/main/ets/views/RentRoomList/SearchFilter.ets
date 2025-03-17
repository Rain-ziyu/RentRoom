import { PADDING } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'

@Component
export default struct SearchFilter {


  build() {

    Row(){
      Row({space:6}){
        Text('位置').fontSize(14).fontColor('#333333')
        Image($r('app.media.arrow_down_3')).width(6).height(3)
      }
      Row({space:6}){
        Text('户型').fontSize(14).fontColor('#333333')
        Image($r('app.media.arrow_down_3')).width(6).height(3)
      }
      Row({space:6}){
        Text('租金').fontSize(14).fontColor('#333333')
        Image($r('app.media.arrow_down_3')).width(6).height(3)
      }
      Row({space:6}){
        Text('排序').fontSize(14).fontColor('#333333')
        Image($r('app.media.arrow_down_3')).width(6).height(3)
      }
    }.width('100%')

    .padding({left:PADDING,right:PADDING})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}