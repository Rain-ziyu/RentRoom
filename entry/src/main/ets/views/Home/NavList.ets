import type { BannerListDataSource, IBannerItem, IBannerList, INavItem, INavList } from '../../models/HomeData'

@Component
export default struct NavList {
  @Link navList: INavList;

  build() {
    Grid() {
      ForEach(this.navList,(nav: INavItem)=>{
        GridItem(){
          Column(){
            Image(nav.imageURL).width(58).height(56).objectFit(ImageFit.Fill)
            Text(nav.title).fontSize(12).fontColor($r('app.color.black'))
          }
        }
      },(index:INavItem)=> index.id+'')
    }.width('100%')
    .height(170)
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(14)
    .columnsGap(32)
    .margin({top:24})
  }
}