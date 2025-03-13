import NavBar from '../../components/NavBar/Index'
@Entry
@Component
struct RentRoomList {
  @State message: string = 'Hello World';

  build() {
    Column(){
      NavBar({title:'服务列表'})
    }
    .height('100%')
    .width('100%')
  }
}