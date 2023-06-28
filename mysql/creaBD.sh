#!/bin/bash

#Ruta al fichero de configuracion de MySQL
mysqlCnf=/etc/mysql/my.cnf

#Si la versión de MySQL Server es 5.7 entonces
if [ `mysql -V | grep 5.7 | wc -l` == 1 ]
then

	mysqlCnf=/etc/mysql/mysql.conf.d/mysqld.cnf

fi



##
#
#	Esta función reinicia el servicio MySQL
#
##
function reiniciarMySQL()
{
	
	echo
	echo
	echo '***********************'
	echo '*'
	echo '*'
	echo '*'
	echo Reiniciando servicio MySQL
	echo '*'
	echo '*'
	echo '*'
	echo '***********************'

	sudo /etc/init.d/mysql restart

}



##
#   Modificando el archivo my.cnf de Mysql 
#    
#   --- lower_case_table_names = 1
#   Conflicto de nombres de tablas mayúsculas/minúsculas
#   
#   1º Se comprueba si la directiva esta a 0, de ser así se modifica
#	2º Si no existe, se añada 
#	
#	Si no se cumple, se deduce que ya esta añadida
#
# #
if [ `grep -i lower_case_table_names=0 ${mysqlCnf}  | wc -l` == 1 ]
then

	echo '***********************'
	echo '*'
	echo '*'
	echo '*'
	echo Modificando la directiva lower_case_table_names a 1
	echo '*'
	echo '*'
	echo '*'
	echo '***********************'
	sudo sed -i "s/lower_case_table_names=0/lower_case_table_names=1/g" /etc/mysql/my.cnf
	reiniciarMySQL

elif [ `grep -i lower_case_table_names=1 ${mysqlCnf} | wc -l` == 0 ]
then
	
	aux=`grep '\[mysqld\]' ${mysqlCnf} -n | cut -d ":" -f1`
	((aux++))

	echo '***********************'
	echo '*'
	echo '*'
	echo '*'
	echo Añadiendo directiva lower_case_table_names 
	echo '*'
	echo '*'
	echo '*'
	echo '***********************'
	
	sudo sed -i "${aux}ilower_case_table_names=1" ${mysqlCnf}
	reiniciarMySQL
		
fi

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
