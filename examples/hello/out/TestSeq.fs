#light "off"
module TestSeq
open Prims
open FStar.Seq
type int' = Microsoft.FSharp.Core.bigint

let rec print_seq :
                    int'  ->
                    int' FStar.Seq.seq  ->
                    unit
                  = (fun ( i  :  int' ) ( s  :  int' FStar.Seq.seq ) -> (match ((i = FStar.Seq.length s)) with
| true -> begin
()
end
| uu____20 -> begin
  printfn "%A" (FStar.Seq.index s i);
  print_seq (i + bigint 1) s
end))


let main : unit =
    (print_seq (bigint 0) (FStar.Seq.create (bigint 100) (bigint 0)))
