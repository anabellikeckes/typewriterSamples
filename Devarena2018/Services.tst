${
    using Typewriter.Extensions.WebApi;
    using System.Text.RegularExpressions;
    using Typewriter.Extensions.Types;

     string ToKebabCase(string name) {
        return  Regex.Replace(name, "(?<!^)([A-Z][a-z]|(?<=[a-z])[A-Z])","-$1", RegexOptions.Compiled)
                     .Trim().ToLower();
    }

    string ServiceName(Class cl) => cl.Name.Replace("Controller", "Service");

    string Verb(Method m) => m.Attributes.First(a => a.Name.StartsWith("Http")).Name.Remove(0, 4).ToLowerInvariant();

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
             return "Typescript/Services/" + ToKebabCase(file.Name.Replace("Controller.cs", ".service.ts"));
        };
    }
    
    string ReturnType(Method m) => m.Type.Name == "IHttpActionResult" ? "<void>" : "<" + m.Type.Name +">";

    string Imports(Class objClass)
    {
        var ImportsOutput = "";

        // Loop through the Methdos in the Class
        foreach(Method objMethod in objClass.Methods)
        {
            foreach(var objParameter in objMethod.Type.TypeArguments)
            {
                    ImportsOutput = objParameter.Name;
            }
        }
        // Notice: As of now this will only return one import
        return  ImportsOutput.ToString() != "" ? $"import {{ { ImportsOutput } }} from '../Models/{ToKebabCase(ImportsOutput)}';\r\n" : null;
    }

}$Classes(*Controller)[$Imports 
export class $ServiceName {
       constructor(private http: HttpClient) { }
$Methods[
       public $name = ($Parameters[$name: $Type][, ]) => {
           return this.http.$Verb$ReturnType(`$Route`, { $Parameters[$name: $name][, ] });
      }]
}]
    