import type { BannerListDataSource, IBannerItem, IBannerList } from '../../models/HomeData'

@Component
export default struct SwiperLayout {
  @ObjectLink bannerList: BannerListDataSource;

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height('100%').objectFit(ImageFit.Fill)
      }, (item: IBannerItem) => item.id + '')
    }
    .width('100%')
    .height(211 - 36)
    .autoPlay(true) //自动滚动
    .interval(1) //1s一次
    .indicator(
      // 设置圆点的导航样式
      new DotIndicator()
        .color('#CCCBCB')
        .selectedColor('#479559')
    )
  }
}