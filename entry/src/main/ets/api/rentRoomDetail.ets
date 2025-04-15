import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { IRentRoomDetail, IReservationRoomParam } from '../models/RentRoomData';
import { IServiceData } from '../models/ServiceData';
import { http } from '../util/http/index';
// 房源详细数据
export const getRoomDetailApi = (id:string) :Promise<IRentRoomDetail>=> {
  return http.get<IRentRoomDetail>('/house/detail',{id})
}
// 房源详细数据
export const reservationRoomApi = (data:IReservationRoomParam) :Promise<null>=> {
  return http.post<null>('/auth/house/reservation',data)
}