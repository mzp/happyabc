open OptParse

let (@@) f g =  f g
let ($) f g x = f (g x)

let opt =
  OptParser.make ~version:"<VERSION>" ~usage:"habc [options] <file>" ()

let make_temp source ext =
  Printf.sprintf "%s.%s" (Filename.chop_extension source) ext

let abc_of_scm scm =
  let abc = 
    make_temp scm "abc" in
    ignore @@ Unix.system @@ Printf.sprintf "habc-scm -o%s %s" abc scm;
    abc

let xml_of_abc abc =
  abc

let xml_of_xml xml =
  xml

let swf_of_xml xml =
  xml

let _ =
  let inputs =
    OptParser.parse_argv opt in
    if inputs = [] then
      OptParser.usage opt ()
    else 
      List.iter (ignore $ swf_of_xml $xml_of_xml $xml_of_abc $ abc_of_scm) inputs

