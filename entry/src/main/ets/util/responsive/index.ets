const  DRAFT_WIDTH = 360
export default function rvp(designWidth:number){
//   计算元素真正的大小
//   x=元素设计稿的大小/设计稿总宽度*真机宽度
  console.log('aaaaaaaaaaaaaaaa'+AppStorage.get('windowWidth'))
  // return designWidth/DRAFT_WIDTH+(AppStorage.get('windowWidth') as number)
  return designWidth
}
export  function md(){
  //   计算元素真正的大小
  //   x=元素设计稿的大小/设计稿总宽度*真机宽度
  console.log('aaaaaaaaaaaaaaaa'+AppStorage.get('windowWidth'))
  // return designWidth/DRAFT_WIDTH+(AppStorage.get('windowWidth') as number)
  return 14
}
export function sm(){
  return 12
}
export function xs(){
  return 10
}
export function xl(){
  return 16
}