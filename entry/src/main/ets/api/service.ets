import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { IServiceData } from '../models/ServiceData';
import { http } from '../util/http/index';
// 获取服务页信息
export const getServiceDataApi = () :Promise<IServiceData>=> {
  return http.get<IServiceData>('/service/info')
}