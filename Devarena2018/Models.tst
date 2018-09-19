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

    string RemoveArrayFromImport(string propertyName){
        return propertyName.Replace("[]","");
    }

    string Imports(Class c) => (c.BaseClass != null ? "import { " + c.BaseClass.Name + " } from './" + ToKebabCase(c.BaseClass.Name) + "';\r\n" : null) +
                               c.Properties
                                .Where(p => !p.Type.IsPrimitive || p.Type.IsEnum)
                                .Select(p => RemoveArrayFromImport(p.Type.Name) )
                                .Distinct()
                                .Select(name => "import { " + name  + "} from './" + ToKebabCase(name.ToString()) + "';")
                                .Aggregate("", (all,import) => $"{all}{import}\r\n")
                                .TrimStart() + (c.BaseClass != null || c.Properties.Any(pr => !pr.Type.IsPrimitive || pr.Type.IsEnum) ? "\r\n" : "");

}$Classes(Devarena2018.Models*)[$Imports export class $ClassNameWithExtends$TypeParameters {
$Properties[
        $name: $Type;]
}
]$Enums(Devarena2018.Enums*)[export enum $Name { $Values[
    $Name = $Value][,]
}
]$Classes(*Controller)[$Imports export class $ServiceName {
       constructor(private http: IHttpService) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.http.$Verb$Type[$IsGeneric[$TypeArguments][<void>]](`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    