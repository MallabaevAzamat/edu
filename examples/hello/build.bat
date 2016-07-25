@echo off

echo %FSTAR_HOME%\fstar --odir out --codegen FSharp hello.fst
echo fsc  --mlcompatibility -r %FSTAR_HOME%\FSharp.PowerPack.dll --nowarn:0086 -o out\hello.exe %FSTAR_HOME%\..\ulib\fs\prims.fs %FSTAR_HOME%\..\ulib\fs\io.fs out\Hello.fs

echo %FSTAR_HOME%\fstar --odir out --codegen FSharp testseq.fst
fsc  --mlcompatibility -r %FSTAR_HOME%\FSharp.PowerPack.dll --nowarn:0086 -o out\testseq.exe %FSTAR_HOME%\..\ulib\fs\prims.fs %FSTAR_HOME%\..\ulib\fs\io.fs out\FStar.Seq.fs out\Testseq.fs