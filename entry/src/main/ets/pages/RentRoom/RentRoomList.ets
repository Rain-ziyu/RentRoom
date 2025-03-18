import NavBar from '../../components/NavBar/Index'
import RoomList from '../../views/RentRoomList/RoomList';
import SearchFilter from '../../views/RentRoomList/SearchFilter';

@Entry
@Component
struct RentRoomList {
  @State message: string = 'Hello World';
  @StorageProp('topHeight') topHeight :number=0;
  build() {
    Stack(){

      RoomList()
      SearchFilter()
      Row(){NavBar({title:'服务列表'})}.backgroundColor($r('app.color.white'))

    }
    .height('100%')
    .width('100%')
    .alignContent(Alignment.TopStart)
.padding({top:this.topHeight})
  }
}