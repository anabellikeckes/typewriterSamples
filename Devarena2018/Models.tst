${
    using Typewriter.Extensions.WebApi;
    using System.Text.RegularExpressions;
    using Typewriter.Extensions.Types;

     string ToKebabCase(string name){
        return  Regex.Replace(name, "(?<!^)([A-Z][a-z]|(?<=[a-z])[A-Z])","-$1", RegexOptions.Compiled)
                     .Trim().ToLower();
    }

    string ServiceName(Class cl) => cl.Name.Replace("Controller", "Service");
    string Verb(Method m) => m.Attributes.First(a => a.Name.StartsWith("Http")).Name.Remove(0, 4).ToLowerInvariant();

    
    string ClassNameWithExtends (Class c) {
        return c.Name +  (c.BaseClass!=null ? " extends " + c.BaseClass.Name : "");
    }

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
            if(file.Name.Contains("Controller")){
             return ToKebabCase(file.Name.Replace("Controller.cs", ".service.ts"));
            }else{
            return ToKebabCase(file.Name.Replace(".cs", ".ts"));
            }
        };
    }

    string Imports(Class c)
    {
        var baseType = (Type)c.BaseClass;
        return baseType!= null? "import { " + c.BaseClass.Name + " } from './" + ToKebabCase(c.BaseClass.Name) + "';\n\n" : null;
    }
}$Classes(Devarena2018.Models*)[$Imports export class $ClassNameWithExtends$TypeParameters {
$Properties[
        $name: $Type;]
}
]$Enums(Devarena2018.Enums*)[export enum $Name { $Values[
    $Name = $Value][,]
}
]$Classes(*Controller)[ export class $ServiceName {
       constructor(private http: IHttpService) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.http.$Verb$Type[$IsGeneric[$TypeArguments][<void>]](`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    