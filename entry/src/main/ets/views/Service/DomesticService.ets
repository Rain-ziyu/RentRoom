import { PADDING } from "../../constants/size"
import rvp from "../../util/responsive"
import { window } from "@kit.ArkUI"
import Card from '../../components/Card/Index'

@Component
export default struct DomesticService {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
      Card() {
        // 默认插槽
        Text("DomesticService")
      }
    }
    .width('100%').margin({top:43})

  }
}