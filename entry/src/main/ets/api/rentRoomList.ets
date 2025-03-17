import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { IGetRentRoomListParams, IGetRentRoomListResponse } from '../models/RentRoomList';
import { http } from '../util/http/index';

// 搜索房源数据
export   const searchRoomListApi = (params:IGetRentRoomListParams) :Promise<IGetRentRoomListResponse>=> {
  return http.get<IGetRentRoomListResponse>('/house/search',params)
}

