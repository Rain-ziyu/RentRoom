import rvp from "../../util/responsive"
import Avatar from '../../components/Avatar/Index'
import { router } from "@kit.ArkUI"
import IUserData from "../../models/UserData";
import { getUserInfo } from "../../api/login";

@Component
export default struct UserInfo {
  @State avatarSrc: string = ''
  @StorageProp('user') user: IUserData = {
    id: '',
    nickname: '',
    avatar: ''
  };
  @StorageProp('token') token: string = ''

  async aboutToAppear(): Promise<void> {
    console.log('token:'+this.token)
    if (this.user.id||!this.token) {
      return;
    }

    const userData = await getUserInfo()
    AppStorage.setOrCreate('user', userData)
  }

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.user.avatar, avatarSize: rvp(60) })
        .onClick(() => {
          if (this.user.id) {
            return
          }
          router.pushUrl({
            url: 'pages/Login/LoginPhone'
          })
        })
      if (this.user.nickname) {
        Column({ space: rvp(4) }) {
          Text('Hi，' + this.user.nickname).fontSize(rvp(16)).fontColor($r('app.color.white')).fontWeight(700)
          Text('谷粒点15').fontSize(rvp(12)).fontColor($r('app.color.white'))
        }.alignItems(HorizontalAlign.Start)
      } else {
        Text('请登录').fontSize(16).fontColor($r('app.color.white')).fontWeight(700)
      }

    }.margin({ top: rvp(11) }).width('100%')
  }
}