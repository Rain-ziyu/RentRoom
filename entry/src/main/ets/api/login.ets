import type { IHomeData, IRoomRecommendItem, IRoomRecommendList } from '../models/HomeData';
import IUserData from '../models/UserData';
import { http } from '../util/http/index';
interface IResponse{
  token :string
}
export const sendSMSCode = (phone:string) :Promise<null>=> {
  return http.post<null>('/sendSMSCode',{phone})
}

export const loginApi = (phone:string,code:string):Promise<IResponse>=> {
  return http.post<IResponse>('/login',{phone,code})
}


export const getUserInfo = ():Promise<IUserData>=> {
  return http.get<IUserData>('/auth/user/userInfo')
}