(*--build-config
    options:--admit_fsi Set --z3timeout 10 --logQueries;
    variables:LIB=../../lib;
    other-files:$LIB/ext.fst $LIB/set.fsi $LIB/heap.fst $LIB/st.fst $LIB/list.fst  stack.fst listset.fst
    st3.fst $LIB/constr.fst word.fst $LIB/seq.fsi $LIB/seq.fst array.fsi array.fst withScope.fst
  --*)
module ArrayAlgos
open StructuredMem
open MVector
open Heap
open Set
open MachineWord
open Array
open MD5Common
open Seq

val contains : #a:Type -> smem -> array a -> GTot bool
let contains m v = refExistsInMem (asRef v) m

val sel : #a:Type -> m:smem -> v:(array a){contains m v} -> GTot (seq a)
let sel m v = loopkupRef (asRef v) m

val glength : #a:Type -> v:(array a) -> m:smem{contains m v} -> GTot nat
let glength v m = Seq.length (sel m v)

type prefixEqual  (#a:Type)
  (v1: seq a) (v2: seq a) (p:nat{p <= length v1 /\ p<= length v2})
  = forall (n:nat{n<p}). index v1 n = index v2 n

(* Helper functions for stateful array manipulation *)
val copy:
  #a:Type -> s:array a -> scp :array a
  -> WNSC unit
     (requires (fun h -> contains h s /\ contains h scp /\ glength s h <= glength scp h))
     (ensures (fun h0 _ h1 -> (contains h1 s) /\  (contains h1 scp)
				      (*/\ sel h1 s = sel h1 scp *)
              ))
     (only (asRef scp))
let copy s scp =
  let ctr = salloc #nat 0 in
  let len = Array.length s in
  scopedWhile1
    ctr
    (fun ctrv -> ctrv < len)
    (fun m -> contains m s /\ contains m scp
        /\ len = glength s m /\ len <= glength scp m
          /\ refExistsInMem ctr m
          /\ (loopkupRef ctr m) <=len
          /\ prefixEqual (sel m s) (sel m scp) (loopkupRef ctr m)
          )
    (only (asRef scp))
    (fun u -> let ctrv = memread ctr in
              (*writeIndex scp ctrv (readIndex s ctrv);*)
              memwrite ctr (ctrv (*+1*) ))