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

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
             return ToKebabCase(file.Name.Replace("Controller.cs", ".service.ts"));
        };
    }

    string Imports(Class c) => (c.BaseClass != null && c.BaseClass.Name != "Controller" ? "import { " + c.BaseClass.Name + " } from './" + ToKebabCase(c.BaseClass.Name) + "';\r\n" : null) +
                               c.Properties
                                .Where(p => !p.Type.IsPrimitive || p.Type.IsEnum)
                                .Select(p => p.Type.Name)
                                .Distinct()
                                .Select(name => "import { " + name  + " } from './" + ToKebabCase(name.ToString()) + "';")
                                .Aggregate("", (all,import) => $"{all}{import}\r\n")
                                .TrimStart() + (c.BaseClass != null || c.Methods.Any(pr => !pr.Type.IsPrimitive || pr.Type.IsEnum) ? "\r\n" : "");

}$Classes(*Controller)[$Imports export class $ServiceName {
       constructor(private http: IHttpService) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.http.$Verb$Type[$IsGeneric[$TypeArguments][<void>]](`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    