﻿${
    using System.Text.RegularExpressions;
    using Typewriter.Extensions.Types;

     string ToKebabCase(string name) {
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
            return ToKebabCase(file.Name.Replace(".cs", ".ts"));
        };
    }

    string RemoveArrayFromImport(string propertyName) {
                return propertyName.Replace("[]","");
    }

    string checkAbstract(Class c) {
        if (c.IsAbstract) {
            return "abstract";
        } else {
            return null;
        }
    }

    string Imports(Class c) => (c.BaseClass != null && c.BaseClass.Name != "Controller" ? "import { " + c.BaseClass.Name + " } from './" + ToKebabCase(c.BaseClass.Name) + "';\r\n" : null) +
                               c.Properties
                                .Where(p => !p.Type.IsPrimitive || p.Type.IsEnum)
                                .Select(p => RemoveArrayFromImport(p.Type.Name))
                                .Distinct()
                                .Select(name => name != "T" ? "import { " + name  + " } from './" + ToKebabCase(name.ToString()) + "';" : null)
                                .Aggregate("", (all,import) => $"{all}{import}\r\n")
                                .TrimStart() + (c.BaseClass != null || c.Properties.Any(pr => !pr.Type.IsPrimitive || pr.Type.IsEnum) ? "\r\n" : "");
}$Classes(Devarena2018.Models*)[$Imports export $checkAbstract class $ClassNameWithExtends$TypeParameters {
$Properties[
       $name: $Type;]
}
]$Enums(Devarena2018.Enums*)[export enum $Name {
$Values[
    $Name = $Value][,]
}]
    