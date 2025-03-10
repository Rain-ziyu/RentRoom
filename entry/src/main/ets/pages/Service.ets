import ScrollContainer from '../components/ScrollContainer/Index'
import Bg from '../views/Service/Bg'
import NavBar from '../views/Service/NavBar'

@Component
export default struct Service {
  @Builder
  navBuilder(){}
  @Builder
  contentBuilder(){
      Stack(){
        Bg()
        NavBar()
      }.width('100%')
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