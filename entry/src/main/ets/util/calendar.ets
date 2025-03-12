export  default function getCalendar(){
  const date = new Date();
  const  currentMonth = date.getMonth()+1;
  return [
    calcLastMonth(currentMonth,2),
  calcLastMonth(currentMonth,1),
    currentMonth,
  calcNextMonth(currentMonth,1),
  calcNextMonth(currentMonth,2)
  ].map(val =>addZero(val))
}
function  calcLastMonth(currentMonth:number,num:number){
  const val = currentMonth -num-1
  return (val +12)%12+1
}
function  calcNextMonth(currentMonth:number,num:number){
  const val = currentMonth +num-1
  return (val +12)%12+1
}

function addZero (val:number):string{
  return val<10?'0'+val:val+''
}