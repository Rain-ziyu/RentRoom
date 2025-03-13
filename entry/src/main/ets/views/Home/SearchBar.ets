import { PADDING, PADDING_S } from '../../constants/size'
import type { BannerListDataSource, IBannerItem, IBannerList } from '../../models/HomeData'
import { router } from '@kit.ArkUI'

@Component
export default struct SearchBar {
  @Prop fontColor:string
  build() {
    Row({ space: PADDING }) {
      Text('北京').fontSize(14).fontColor(this.fontColor)
      Stack() {
        TextInput().width('100%').height('100%').backgroundColor($r('app.color.white'))
          .border({width:1,color:$r('app.color.gray')})
        Row() {
          Image($r('app.media.search')).width(18).height(18)
          Text('公交、地铁')
            .fontSize(10)
            .fontColor($r('app.color.gray'))
            .layoutWeight(1)
            .margin({ left: PADDING_S, right: PADDING_S })
          Column() {
          }.width(1).height(18).backgroundColor($r('app.color.black')).margin({ right: PADDING_S })

          Image($r('app.media.position')).width(18).height(18)
        }.width('100%').padding({ left: PADDING, right: PADDING })
      }.width(244).onClick(()=>{
        router.pushUrl({
          url:'pages/RentRoom/RentRoomList'
        })
      })

      Image($r('app.media.message')).width(24).height(24).fillColor(this.fontColor)
    }.width('100%')
    .height(38)
    .padding({ left: PADDING, right: PADDING , top: 4 ,bottom:4})

  }
}