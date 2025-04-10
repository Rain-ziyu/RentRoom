import NavBar from '../../components/NavBar/Index'
import { faceDetector } from '@kit.CoreVisionKit'
import { PADDING } from '../../constants/size'
import { router } from '@kit.ArkUI'

@Component
@Entry
export default struct LoginPhone {
  @State phone: string = ''
  handlerPhoneChange = (val: string) => {
    this.phone = val
    this.isValidPhone = val.length === 11 && this.phoneReg.test(val)
  }
  handlerAgree = (val: boolean) => {
    this.isAgree = val;
  }
  phoneReg = /^1[3-9][0-9]{9}$/
  @StorageProp('topHeight') topHeight: number = 0
  @State isValidPhone: boolean = false
  @State isAgree: boolean = false

  build() {
    Column() {
      NavBar({ title: '验证码登录' })
      Column() {
        Stack() {
          TextInput({ placeholder: '请输入手机号' })
            .backgroundColor('rgba(0,0,0,0)')
            .fontSize(16)
            .fontColor($r('app.color.black'))// 输入类型
            .type(InputType.Number)
            .maxLength(11)
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
            .onChange(this.handlerPhoneChange)
          if (this.isValidPhone) {
            Image($r('app.media.success')).width(12).height(8)
          }
        }.alignContent(Alignment.End)

        Row({ space: 6 }) {
          Checkbox()
            .select(this.isAgree)
            .onChange(this.handlerAgree)
            .selectedColor($r('app.color.primary'))
            .width(12)
            .height(12)
          Text() {
            Span('同意').fontColor('#C1C1C1')
            Span('《用户协议》').fontColor($r('app.color.primary'))
            Span('和').fontColor('#C1C1C1')
            Span('《隐私协议》').fontColor($r('app.color.primary'))
          }.fontSize(12)
        }
        .width('100%').margin({ top: PADDING })
        .alignSelf(ItemAlign.Start)

        Button('获取验证码')
          .width(100)
          .height(40)
          .margin({ top: 40 })
          .alignSelf(ItemAlign.End)// .backgroundColor($r('app.color.primary'))
          .backgroundColor(this.isValidPhone===true&&this.isAgree===true?$r('app.color.primary'):'#F0F0F0')
          .fontColor(this.isValidPhone===true&&this.isAgree===true?$r('app.color.white'):'#C1C1C1')
          .stateEffect(this.isValidPhone===true&&this.isAgree===true)
          .onClick(()=>{
            router.pushUrl({
              url:'pages/Login/LoginCode',
              params:{
                phone:this.phone
              }
            })
          })
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