import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import Bg from '../views/Service/Bg'
import NavBar from '../views/Service/NavBar'
import VIP from '../views/Service/VIP'

@Component
export default struct Service {

  @Builder
  navBuilder(){
    NavBar()
  }
  @Builder
  contentBuilder(){
      Stack(){
        Bg()
        Column(){
          VIP()
        }.width('100%').padding({left:PADDING,right:PADDING})
      }.width('100%').alignContent(Alignment.TopStart).backgroundColor($r('app.color.bg_gray_second'))
  }
  build() {
    Row() {
      ScrollContainer({
        navBuilderParam:this.navBuilder,
        contentBuilderParam:()=>{
          this.contentBuilder()
        }
      })
    }
  }
}