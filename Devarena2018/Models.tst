${

    string ServiceName(Class cl) => cl.Name.Replace("Controller", "Service");
    string Verb(Method m) => m.Attributes.First(a => a.Name.StartsWith("Http")).Name.Remove(0, 4).ToLowerInvariant();

    
    string ClassNameWithExtends (Class c) {
        return c.Name +  (c.BaseClass!=null ?  " extends " + c.BaseClass.Name : "");
    }

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
            if(file.Name.Contains("Controller")){
             return $"{file.Name.Replace("Controller.cs", "Service.ts")}";
            }else{
            return file.Name.Replace(".cs", ".ts");
            }
        };
    }
}

$Classes(*Model)[ export class $ClassNameWithExtends$TypeParameters { 
$Properties[
         $name: $Type;]
}
]

$Enums(*Enum)[export enum $Name { $Values[
    $Name = $Value][,]
}]

$Classes(*Controller)[
export class $ServiceName {
       constructor(private $http: ng.IHttpService) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.$http.$Verb$Type[$IsGeneric[$TypeArguments][<void>]](`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    