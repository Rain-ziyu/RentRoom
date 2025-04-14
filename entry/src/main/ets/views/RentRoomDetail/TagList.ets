import { ITagItem, ITagList } from "../../models/HomeData"
import rvp, { xs } from "../../util/responsive"


@Component
export default struct TagList {
  @Link tagList: ITagList

  build() {
    Row({ space: rvp(14) }) {
      ForEach(this.tagList.slice(0, 4), (item:ITagItem )=> {
        Text(item.name).fontSize(xs()).backgroundColor('#F8F9FC').padding({ top: rvp(4), bottom: rvp(4), left: rvp(8), right: rvp(8) })
      }, (item:ITagItem ) => item.name)
    }.width('100%').margin({ top: rvp(8) })
  }
}


