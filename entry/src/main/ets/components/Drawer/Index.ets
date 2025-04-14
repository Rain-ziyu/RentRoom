import rvp from "../../util/responsive";

@Component
export default struct Drawer {
  @Link show: boolean;
  @BuilderParam render: () => void
  @Require @Prop heights:number=0
  build() {
    if (this.show) {
      Stack() {
        Column() {
        }.width('100%').height('100%').backgroundColor('rgba(0, 0, 0, 0.7)').onClick(() => {
          this.show = false;
        })

        Column() {
          this.render()
        }
        .backgroundColor('#F6F6F6')
        .width('100%')
        .padding(rvp(15))
        .borderRadius({
          topLeft: rvp(10),
          topRight: rvp(10)
        })
        .transition(
          TransitionEffect.translate({x:0,y:this.heights}).animation({duration:2000})
            .combine(TransitionEffect.translate({x:0,y:181}).animation({duration:2000}))
        )
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
      .zIndex(999)
      .alignContent(Alignment.BottomStart)
    }
  }
}