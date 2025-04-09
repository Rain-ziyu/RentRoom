import rvp from "../../util/responsive"
import Avatar from '../../components/Avatar/Index'
import { router } from "@kit.ArkUI"

@Component
export default struct UserInfo {
  @State avatarSrc: string = ''

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.avatarSrc, avatarSize: rvp(60) })
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/Login/LoginPhone'
          })
        })
      Column({ space: rvp(4) }) {
        Text('Hi，小谷粒').fontSize(rvp(16)).fontColor($r('app.color.white')).fontWeight(700)
        Text('谷粒点15').fontSize(rvp(12)).fontColor($r('app.color.white'))
      }.alignItems(HorizontalAlign.Start)
    }.margin({ top: rvp(11) }).width('100%')
  }
}