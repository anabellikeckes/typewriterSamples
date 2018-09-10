






export class UserService {
       constructor(private $http: ng.IHttpService) { }

       public getAll = () => {
           return this.$http.get<UserModel>(`$Route`, {  });
      }
}
    