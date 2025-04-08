import NavBar from '../views/My/NavBar'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IColor } from '../models/HomeData'
import Bg from '../views/My/Bg'
import UserInfo from '../views/My/UserInfo'
import rvp from '../util/responsive'
import { PADDING } from '../constants/size'

@Component
export default struct My {
  @StorageProp('topHeight') topHeight: number = 0
  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) +this.topHeight })

    }.width('100%')
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}