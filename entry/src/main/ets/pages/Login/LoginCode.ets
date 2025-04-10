import NavBar from '../../components/NavBar/Index'
import { PADDING } from '../../constants/size';
import { router } from '@kit.ArkUI';
import { getUserInfo, loginApi, sendSMSCode } from '../../api/login';

interface IParams {
  phone: string
}


@Entry
@Component
export default struct LoginCode {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageLink('token') token: string = ''
  START_TIME: number = 61
  @State time: number = this.START_TIME
  @State code: string = ''
  @State phone: string = ''
  timer = 0
  sendSMSCode = () => {
    const params = router.getParams() as IParams
    sendSMSCode(params ? params.phone : '13283714235')
    this.countDown()
  }
  handleSMSCodeChange = (val: string) => {
    this.code = val
  }
  login = async () => {
    const result = await loginApi(this.phone, this.code)
    console.log(result.token)
    this.token = result.token
    const userData = await getUserInfo()
    AppStorage.setOrCreate('user', userData)
    router.back({
      url: 'pages/Index'
    })
  }
  countDown = () => {
    // 进入方法立马将time减一，用于隐藏重新获取按钮
    this.time--
    // 定时器第一次执行是在1000ms后，存在延迟问题
    this.timer = setInterval(() => {
      this.time--
      if (this.time === 0) {
        clearInterval(this.timer);
        this.time = this.START_TIME
      }
    }, 1000)
  }

  aboutToAppear(): void {
    this.sendSMSCode()
    const params = router.getParams() as IParams
    this.phone = params ? params.phone : '13283714235'
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
            .onChange(this.handleSMSCodeChange)
          if (this.time === this.START_TIME) {
            Text() {
              Span('重新发送验证码')
            }.fontColor($r('app.color.primary')).fontSize(16).onClick(this.sendSMSCode)
          } else {
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
          .backgroundColor(this.code.length === 6 ? $r('app.color.primary') : '#F0F0F0')
          .fontColor(this.code.length === 6 ? '#ffffff' : '#C1C1C1')
          .stateEffect(this.code.length === 6)
          .onClick(this.login)
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