import { User } from '../Models/user';
 
export class UserService {
       constructor(private http: HttpClient) { }

       public getAll = () => {
           return this.http.get<User[]>(`api/user`, {  });
      }
       public get = (userId: string) => {
           return this.http.get<User>(`api/user/{userId:Guid}`, { userId: userId });
      }
       public delete = (userId: string) => {
           return this.http.delete<void>(`api/user/{userId:Guid}`, { userId: userId });
      }
}
    