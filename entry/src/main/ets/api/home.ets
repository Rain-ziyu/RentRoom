import type { IHomeData } from '../models/HomeData';
import { http } from '../util/http/index';

// 获取首页数据
export const getHomeDataApi = () :Promise<IHomeData>=> {
  return http.get<IHomeData>('/home/info')
}