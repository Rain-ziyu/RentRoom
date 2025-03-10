import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { http } from '../util/http/index';

// 获取首页数据
export const getHomeDataApi = () :Promise<IHomeData>=> {
  return http.get<IHomeData>('/home/info')
}

// 获取首页数据
export const getRoomRecommendListApi = () :Promise<IRoomRecommendList>=> {
  return http.get<IRoomRecommendList>('/house/nearbyHouses')
}
