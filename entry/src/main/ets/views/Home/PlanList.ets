import type { BannerListDataSource, IBannerItem, IBannerList, INavList,
  IPlanItem,
  IPlanList,
  ITileItem,
  ITileList } from '../../models/HomeData'

@Component
export default struct PlanList {
  @Prop planList: IPlanList;

  build() {
    Row({space:5}) {
      ForEach(this.planList,(plan:IPlanItem)=>{
        Image(plan.imageURL).width(78).height(60).objectFit(ImageFit.Fill)
      }, (plan: IPlanItem) => plan.id + '')
    }
    .width('100%')
    .margin({top :18}).justifyContent(FlexAlign.SpaceBetween)
  }
}