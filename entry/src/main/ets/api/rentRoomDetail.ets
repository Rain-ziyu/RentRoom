import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { IRentRoomDetail } from '../models/RentRoomData';
import { IServiceData } from '../models/ServiceData';
import { http } from '../util/http/index';
// 房源详细数据
export const getRoomDetailApi = (id:string) :Promise<IRentRoomDetail>=> {
  return http.get<IRentRoomDetail>('/house/detail',{id})
}