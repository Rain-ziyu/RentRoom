import NavBar from '../../components/NavBar/Index'
import RoomList from '../../views/RentRoomList/RoomList';
import SearchFilter from '../../views/RentRoomList/SearchFilter';

@Entry
@Component
struct RentRoomList {
  @State message: string = 'Hello World';

  build() {
    Column(){
      NavBar({title:'服务列表'})
      SearchFilter()
      RoomList()
    }
    .height('100%')
    .width('100%')
  }
}