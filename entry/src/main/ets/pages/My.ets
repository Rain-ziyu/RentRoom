import NavBar from '../views/My/NavBar'
import ScrollContainer from '../components/ScrollContainer/Index'
import { IColor } from '../models/HomeData'
import Bg from '../views/My/Bg'
import UserInfo from '../views/My/UserInfo'
import rvp from '../util/responsive'
import { PADDING } from '../constants/size'
import TimePlan from '../views/My/TimePlan'
import Order from '../views/My/Order'
import PlanList from '../views/My/PlanList'

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
        TimePlan()
        Order()
        PlanList()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) +this.topHeight })

    }.width('100%').align(Alignment.TopStart)
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