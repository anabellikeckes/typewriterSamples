import { User } from './user';
import { Role } from './role';

 export class Generics<T> {

        userInfo: User[];
        role: Role;
        editModeAvailable: boolean;
}

    