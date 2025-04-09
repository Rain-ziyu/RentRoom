import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import { http } from '../util/http/index';

export const sendSMSCode = (phone:string) :Promise<null>=> {
  return http.post<null>('/sendSMSCode',{phone})
}


