${
    using Typewriter.Extensions.WebApi;
    using Typewriter.Extensions.Types;

    string ServiceName(Class cl) => cl.Name.Replace("Controller", "Service");
    string Verb(Method m) => m.Attributes.First(a => a.Name.StartsWith("Http")).Name.Remove(0, 4).ToLowerInvariant();

    
    string ClassNameWithExtends (Class c) {
        return c.Name.Replace("Model", "") +  (c.BaseClass!=null ? " extends " + c.BaseClass.Name.Replace("Model", "") : "");
    }

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
            if(file.Name.Contains("Controller")){
             return $"{file.Name.Replace("Controller.cs", "Service.ts")}";
            }else{
            return file.Name.Replace("Model.cs", ".ts");
            }
        };
    }

    string Imports(Class c)
    {
        var baseType = (Type)c.BaseClass;
        return baseType!= null? "import { " + c.BaseClass.Name.Replace("Model", "") + " } from './" + c.BaseClass.Name.Replace("Model", "") + "';": null;
    }
}

$Classes(*Model)[$Imports

export class $ClassNameWithExtends$TypeParameters { 
$Properties[
         $name: $Type;]
}
]

$Enums(*Enum)[export enum $Name { $Values[
    $Name = $Value][,]
}]

$Classes(*Controller)[
export class $ServiceName {
       constructor(private http: IHttpService) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.http.$Verb$Type[$IsGeneric[$TypeArguments][<void>]](`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    