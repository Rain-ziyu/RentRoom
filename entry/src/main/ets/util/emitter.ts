import { AnimationOptions } from '@kit.ArkUI';
interface  IEvents {
  [key:string]:ICallback[]
}
type ICallback=(arg:any)=>any
function createEmitter() {
  // 存储自定义事件的容器
  const callbacks :IEvents={

  };
  return {
    on(eventName:string,callback : ICallback){
      if (!callbacks[eventName]){
        callbacks[eventName] = [callback]
      }else {
        callback[eventName].push(callback)
      }
    },
    off(eventName:string,callback? : ICallback){
     const events =  callbacks[eventName]
      if (!events){
        return
      }
      if (callback){
        callbacks[eventName] =  events.filter(cb=>cb!==callback)
      }else {
        callbacks[eventName] = undefined
      }
    },
    emit(eventName:string,arg?:any){
      const  events = callbacks[eventName]
      if (!events){
        return
      }
      events.forEach(cb=>cb(arg))
    }
  }
}

const  globalEmitter = createEmitter()

export default globalEmitter