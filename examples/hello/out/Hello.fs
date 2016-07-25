#light "off"
module Hello
open Prims

let print_message : Prims.string  ->  Prims.unit = (fun ( x  :  Prims.string ) -> (FStar.IO.print_string x))


let main : Prims.unit = (print_message "Hello F*!\n")




