import { IFormatDate, IFormatDateList } from '../models/RentRoomData'

function formatDate(time:number){
  const date = new Date(time)
  const year = date.getFullYear()
  const month = addZero(date.getMonth()+1)
 const hao = date.getDate()
  const day = formatWeekText(hao)
  const tmp :IFormatDate= {
    week:day,
    date:`${year}-${month}-${addZero(hao)}`
  }
  return tmp
}
export default function createDateList(){
  const nowTime = Date.now()
  const oneDayTime = 24*3600*1000
 const dateList:IFormatDateList =[]
  for (let i = 0; i < 7; i++) {
    dateList.push(formatDate(nowTime + i * oneDayTime)) ;
  }
  console.log(JSON.stringify(dateList))
  dateList[0].week = '今天'
  return dateList
}
function  formatWeekText(week:number) {
  switch (week){
    case 1:
      return '周一';
    case 2:
      return '周二';
    case 3:
      return '周三';
    case 4:
      return '周四';
    case 5:
      return '周五';
    case 6:
      return '周六';
      default :
        return'周日'
  }
}
function addZero (val:number):string{
  return val<10?'0'+val:val+''
}