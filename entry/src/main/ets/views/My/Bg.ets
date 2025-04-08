
@Component
export default struct Bg {
  @StorageProp('topHeight') topHeight: number = 0
  build() {
    Column() {
    }.width('100%').height(211 - 36 + this.topHeight).linearGradient({
      angle: 180,
      colors: [
        ['#6DC782', 0],
        ['#8FE1A2', 0.43],
        ['#8FE1A2', 1],
      ]
    })
  }
}