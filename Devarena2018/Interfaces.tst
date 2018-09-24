${
    using System.Text.RegularExpressions;
    using Typewriter.Extensions.Types;

     string ToKebabCase(string name){
        return  Regex.Replace(name, "(?<!^)([A-Z][a-z]|(?<=[a-z])[A-Z])","-$1", RegexOptions.Compiled)
                     .Trim().ToLower();
    }

    string ClassNameWithExtends (Class c) {
        return c.Name +  (c.BaseClass!=null ? " extends " + c.BaseClass.Name : "");
    }

    Template(Settings settings)
    {
        settings.OutputFilenameFactory = file =>
        {
             return "Typescript/Interfaces/" + ToKebabCase(file.Name.Replace(".cs", ".ts"));
        };
    }


} $Classes(Devarena2018.Interfaces*)[export interface $ClassNameWithExtends {
$Properties[
        $name: $Type;]
}]