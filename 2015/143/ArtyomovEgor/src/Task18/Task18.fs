﻿module Task18

open Task15
open Task17

let main (string:string) =
    let rec toMyStr (str:string) (myStr:MyString) i =
        if i < 0
        then 
            myStr
        else 
            toMyStr str (Cons (str.[i], myStr)) (i - 1)
    toMyStr string Empty (string.Length - 1)