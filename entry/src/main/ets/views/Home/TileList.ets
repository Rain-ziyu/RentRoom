import type { BannerListDataSource, IBannerItem, IBannerList, INavList,
  ITileItem,
  ITileList } from '../../models/HomeData'

@Component
export default struct TileList {
  @Prop tileList: ITileList;

  build() {
    Row({space:32}) {
     ForEach(this.tileList,(tile:ITileItem)=>{
       Column({space:8}){
         Image(tile.imageURL).width('100%').height(58).objectFit(ImageFit.Fill)
         Row({space:5}){
           Text(tile.title).fontSize(12).fontColor($r('app.color.black'))
           Text(tile.sub_title).fontSize(10).fontColor($r('app.color.gray'))
         }.width('100%')
       }.width(140)
     },(tile:ITileItem)=>tile.id+'')
    }
    .width('100%')
    .margin({top :12})
  }
}