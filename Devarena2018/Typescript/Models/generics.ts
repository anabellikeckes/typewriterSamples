import { T } from './t';
import { User } from './user';
import { Role } from './role';

 export class Generics<T> {

        genericField: T;
        userInfo: User[];
        role: Role;
        editModeAvailable: boolean;
}

    