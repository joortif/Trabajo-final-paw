#!/bin/bash

cd creacion

export CP=.

for i in `ls ../nb/lib/*`
do
		    
    export CP="$CP:$i"    

done


for i in `ls *.jar`
do
    export CP="$CP:$i"    

done

echo $CP

java -classpath $CP paw.bd.creacion.CreaBD

cd ..
