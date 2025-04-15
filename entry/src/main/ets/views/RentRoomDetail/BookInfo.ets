import Drawer from '../../components/Drawer/Index'
import { BORDER_RADIUS, BORDER_RADIUS_S, PADDING } from '../../constants/size'
import { IFormatDate, IFormatDateList } from '../../models/RentRoomData'
import createDateList from '../../util/dateList'
import rvp, { md, xl } from '../../util/responsive'
import { faceDetector } from '@kit.CoreVisionKit'


@Component
export default struct BookInfo {
  @Link show: boolean
  @State isShowDateList: boolean = false
  @State dateList: IFormatDateList = createDateList()
  @State currentDate: IFormatDate = this.dateList[0]

  build() {
    Drawer({ show: $show, heights: 181 }) {
      Column({ space: rvp(16) }) {
        Text('预约信息').fontSize(xl()).fontWeight(700)
        Column({ space: rvp(20) }) {
          Row({ space: rvp(18) }) {
            Text('姓名').width(rvp(56)).fontSize(md())
            TextInput({ placeholder: '请输入姓名' }).textInputStyles()
          }.width('100%')

          Row({ space: rvp(18) }) {
            Text('手机号').width(rvp(56)).fontSize(md())
            TextInput({ placeholder: '请输入手机号' }).type(InputType.PhoneNumber).maxLength(11).textInputStyles()
          }.width('100%')

          Row({ space: rvp(18) }) {
            Text('预约日期').width(rvp(56)).fontSize(md())
            Row() {
              Text(this.currentDate.date + ' ' + this.currentDate.week).fontSize(md()).fontColor($r('app.color.gray'))
             if(this.isShowDateList){
              Image($r('app.media.arrow_down_3_active')).width(rvp(10)).fillColor($r('app.color.gray'))
                .onClick(()=>{
                  this.isShowDateList = false
                })
             }else {
               Image($r('app.media.arrow_down_2')).width(rvp(10)).fillColor($r('app.color.gray'))
                 .onClick(()=>{
                   this.isShowDateList = true
                 })
             }
            }.layoutWeight(1).justifyContent(FlexAlign.SpaceBetween)
          }.width('100%')

          if (this.isShowDateList) {
            Grid() {
              ForEach(this.dateList, (date: IFormatDate) => {
                GridItem() {
                  Column() {
                    Text(date.week).fontSize(10).fontColor(this.currentDate.date === date.date ? '#24A17B' : '#999')
                    Text(date.date).fontSize(10).fontColor(this.currentDate.date === date.date ? '#24A17B' : '#999')
                  }
                  .height(32)
                  .width(73)
                  .border({ width: 1, color: this.currentDate.date === date.date ? '#24A17B' : '#E4E4E4' })
                  .borderRadius(BORDER_RADIUS_S)
                  .justifyContent(FlexAlign.Center)
                }.onClick(() => {
                  this.currentDate = date
                })
              })

            }
            .width(231)
            .columnsTemplate('1fr 1fr 1fr')

            .columnsGap(6)
            .rowsGap(8)
            .height(118)
            .alignSelf(ItemAlign.End)
            .margin({ bottom: 5 })
          }
          Row({ space: rvp(18) }) {
            Text('备注信息').width(rvp(56)).fontSize(md())
            TextArea({ placeholder: '请输入备注信息' }).textAreaStyles()
          }.width('100%').alignItems(VerticalAlign.Top)
        }
        .alignItems(HorizontalAlign.Start)
        .backgroundColor($r('app.color.white'))
        .padding(rvp(PADDING))

        Button('预约看房')
          .type(ButtonType.Normal)
          .width('100%')
          .height(rvp(42))
          .padding(rvp(13))
          .fontColor($r('app.color.white'))
          .fontSize(md())
          .backgroundColor($r('app.color.primary'))
          .borderRadius(rvp(2))
      }.alignItems(HorizontalAlign.Start).padding({ bottom: rvp(PADDING) })
    }
  }
}

@Styles
function pressedStyles() {
  .backgroundColor('#F6F6F6')
}

@Extend(TextInput)
function textInputStyles() {
  .layoutWeight(1)
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.gray'))
  .placeholderFont({ size: md() })
  .caretColor($r('app.color.gray'))
  .fontSize(md())
  .borderRadius(rvp(BORDER_RADIUS_S))
  .stateStyles({
    pressed: pressedStyles,
  })
  .padding(0)
}

@Extend(TextArea)
function textAreaStyles() {
  .layoutWeight(1)
  .backgroundColor('#F6F6F6')
  .placeholderColor($r('app.color.gray'))
  .placeholderFont({ size: md() })
  .caretColor($r('app.color.gray'))
  .fontSize(md())
  .borderRadius(rvp(BORDER_RADIUS))
  .stateStyles({
    pressed: pressedStyles,
  })
  .padding(rvp(10))
  .height(rvp(60))
}