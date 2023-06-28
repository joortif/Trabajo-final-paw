rem @echo off

cd creacion

set CP=.
for %%i in (..\nb\lib\*.*) do call cpappend.bat %%i
for %%i in (.\*.jar) do call cpappend.bat %%i

java -classpath %CP% paw.bd.creacion.CreaBD

cd ..
