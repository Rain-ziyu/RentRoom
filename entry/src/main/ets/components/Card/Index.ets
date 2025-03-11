import { IColor } from "../../models/HomeData";
import { window } from "@kit.ArkUI";
import { BORDER_RADIUS } from "../../constants/size";

@Component
export default struct Index {
  @Builder
  customBuilder() {
  }
  @Prop cardPadding:number=8;

  @StorageProp('topHeight') topHeight: number = 0
  @BuilderParam contentBuildParam: () => void = this.customBuilder


  build() {
    Column() {
      this.contentBuildParam()
    }.width('100%').padding(this.cardPadding).borderRadius(BORDER_RADIUS)
    .backgroundColor($r('app.color.white'))
  }
}