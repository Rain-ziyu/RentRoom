import NavBar from '../../components/NavBar/Index'
import { PADDING } from '../../constants/size';
import { router } from '@kit.ArkUI';
import { sendSMSCode } from '../../api/login';

interface IParams {
  phone: string
}

@Entry
@Component
struct LoginCode {
  @StorageProp('topHeight') topHeight: number = 0
  START_TIME :number= 6
  @State time:number = this.START_TIME

  timer = 0
  sendSMSCode = () => {
    const params = router.getParams() as IParams
    sendSMSCode(params?params.phone:'13283714235')
    this.countDown()
  }
  countDown=()=>{
    // 进入方法立马将time减一，用于隐藏重新获取按钮
    this.time --
    // 定时器第一次执行是在1000ms后，存在延迟问题
    this.timer = setInterval(()=>{
      this.time --
      if(this.time===0){
        clearInterval(this.timer);
        this.time = this.START_TIME
      }
    },1000)
  }
  aboutToAppear(): void {
    this.sendSMSCode()
  }
  onPageHide(): void {
    clearInterval(this.timer)
  }
  aboutToDisappear(): void {
    clearInterval(this.timer)
  }
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
          if (this.time===this.START_TIME){
            Text() {
              Span('重新发送验证码')
            }.fontColor($r('app.color.primary')).fontSize(16).onClick(this.sendSMSCode)
          }else {
            Text() {
              Span(this.time + '')
              Span('s')
            }.fontColor($r('app.color.primary')).fontSize(16)
          }
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