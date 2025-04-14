import type { IHouseholdItem, IHouseholdList,GeneratedTypeLiteralInterface_1 } from '../../models/RentRoomData';
import rvp, { md, xl } from '../../util/responsive';


@Component
export default struct HouseholdItem {
  @Link householdList: IHouseholdList

  build() {
    Column({ space: rvp(16) }) {
      Text('物品配置').fontSize(xl()).fontWeight(700)
      ForEach(this.householdList, (household :IHouseholdItem)=> {
        Column({ space: rvp(16) }) {
          Row({ space: rvp(10) }) {
            Text(household.name).fontSize(md()).fontWeight(700)
            Text(`${household.itemList.length}件物品`).grayText(10)
          }
          Grid() {
            ForEach(household.itemList, (item :GeneratedTypeLiteralInterface_1) => {
              GridItem() {
                Row({ space: rvp(4) }) {
                  Image(item.icon).width(rvp(16))
                  Text(item.value).grayText(14)
                }.justifyContent(FlexAlign.Start).width('100%')
              }
            }, (item :GeneratedTypeLiteralInterface_1) => item.value)
          }
          .columnsTemplate('1fr 1fr 1fr')
          .rowsGap(rvp(16))
          .width('100%')
          .height(rvp(16 * 3))
        }.alignItems(HorizontalAlign.Start)
      }, (household :IHouseholdItem) => household.name)
    }.alignItems(HorizontalAlign.Start).margin({ top: rvp(20) })
  }
}

@Extend(Text) function grayText(size: number) {
  .fontColor($r('app.color.gray')).fontSize(rvp(size))
}


