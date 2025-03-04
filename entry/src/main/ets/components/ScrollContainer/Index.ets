import { IColor } from "../../models/HomeData";
import { window } from "@kit.ArkUI";

@Component
export default struct  Index{
  @Builder customBuilder(){}
  @StorageProp('topHeight') topHeight : number = 0
  @BuilderParam navBuilderParam:($$:IColor)=>void =this.customBuilder
  @BuilderParam contentBuilderParam:()=>void=this.customBuilder
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string =  'rgba(255, 255, 255, 1)'
  windowClass? :window.Window
  scrollY:number = 0;
  handleScroll: ScrollOnScrollCallback = (xOffset: number,yOffset: number)=>{
    this.scrollY+=yOffset
    console.log('y轴'+this.scrollY)
    this.calcColor()
  }
  aboutToAppear(): void {
    this.setWindowStatusColor()
  }
  // 设置 window 状态栏颜色
  setWindowStatusColor = async () => {
    this.windowClass = await window.getLastWindow(getContext())
  }

  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY < 10) {
      this.fontColor = 'rgba(255, 255, 255, 1)'
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor:'#ffffff',
        navigationBarContentColor:'#ffffff'
      })
    } else if(this.scrollY<=300){
      const  colorOpacity = (this.scrollY-10)/(300-10)
      this.bgColor = `rgba(255, 255, 255, ${colorOpacity})`
      this.fontColor = `rgba(0, 0, 0,${colorOpacity})`

    }else {
      this.fontColor = 'rgb(0, 0, 0)'
      this.bgColor = 'rgb(255, 255, 255)'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: '#000000',
        navigationBarContentColor: '#000000'
      })
    }
    console.log( this.fontColor,this.bgColor)
  }
  build() {
    Stack() {
      Scroll() {
        Column() {
          this.contentBuilderParam()
        }
        .width('100%').justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .onDidScroll(this.handleScroll)
      Column(){
        this.navBuilderParam({fontColor:this.fontColor})
      }.padding({top:this.topHeight}).backgroundColor(this.bgColor)

    }.width('100%').height('100%').align(Alignment.TopStart)
  }
}