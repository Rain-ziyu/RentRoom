import NavBar from '../../components/NavBar/Index'
import { PADDING } from '../../constants/size';

@Entry
@Component
struct LoginCode {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
      NavBar({ title: '验证码登录' })
      Column() {
        Stack() {
          TextInput({ placeholder: '请输入验证码' })
            .backgroundColor('rgba(0,0,0,0)')
            .fontSize(16)
            .fontColor($r('app.color.black'))// 输入类型
            .type(InputType.Number)
            .maxLength(6)
            .placeholderColor('#C1C1C1')
            .placeholderFont({ size: 16 })
            .border({
              width: {
                bottom: 1
              },
              color: '#C4EDCE'
            })
            .borderRadius(0)
            .padding({
              top: 8,
              bottom: 8,
              left: 0,
              right: 0
            })//   修改光标颜色
            .caretColor($r('app.color.primary'))
          Text() {
            Span('32')
            Span('s')
          }.fontColor($r('app.color.primary')).fontSize(16)
        }.alignContent(Alignment.End)


        Button('确认')
          .width(100)
          .height(40)
          .margin({ top: 40 })
          .alignSelf(ItemAlign.End)// .backgroundColor($r('app.color.primary'))
          .backgroundColor('#F0F0F0')
          .fontColor('#C1C1C1')
          .stateEffect(true)

      }
      .width('100%')
      .padding({ left: 37, right: 37, top: 40 })
    }.width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#DEFBE5', 0], ['#ffffff', 0.2]]
    })
    .padding({ top: this.topHeight })
  }
}