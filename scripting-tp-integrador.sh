#!/bin/bash
# Menú TP Integrador - Computación Aplicada

# Genera Serie de Fibonacci de un número entero.
function fibonacci() {
echo -n "Ingrese un número entero: "
read numero
a=0
b=1
if [[ ! "$numero" =~ ^[0-9]+$ ]]
then
    echo "Sólo números enteros"
else
	echo "La serie de Fibonacci es la siguiente: "
	for (( i=0; i<numero; i++ ))
	do
        echo -n "$a "
        fn=$((a + b)) 
        a=$b 
        b=$fn 
	done
    echo -e "\nListo"
fi
}

# Invierte un número entero
function numero_entero_invertido() {
echo -n "Ingrese un número entero: "
read numero
numoriginal=$numero
resto=0
invertido=0
if [[ ! "$numero" =~ ^[0-9]+$ ]]
then
    echo "Sólo números enteros"
else
    while [ $numero -gt 0 ]
    do
        resto=$(( $numero % 10 ))
        invertido=$(( $invertido * 10 + $resto ))
        numero=$(( $numero / 10 ))
    done
    echo "El número invertido de $numoriginal es $invertido"
    echo -e "\nListo"
fi
}

# Verifica si es un Palíndromo
function palindromo() {
shopt -s nocasematch
read -p "Ingrese una cadena de caracteres: " cadena
if [[ $(rev <<< "$cadena") == "$cadena" ]]; then
    echo "$cadena es un Palíndromo"
else
	echo "$cadena no es un Palíndromo"
fi
}

# Cuenta la cantidad de lineas de un archivo
function cantidad_lineas_archivo() {
read -p 'Ingrese la ruta a un archivo de texto por ejemplo, "/etc/hosts": ' ruta
echo "$(cd "$(dirname "$ruta")"; pwd -P)/$(basename "$ruta")"
# echo "La cantidad de lineas de $ruta es la siguiente: "
echo "La cantidad de líneas es la siguiente: "
wc -l $ruta | awk '{ print $1 }'
}

function ordenar_cinco_enteros() {
lista_ordinales=(primer segundo tercero cuarto quinto)

for ((i = 0; i < 5; i++)); do
    echo "Ingrese el ${lista_ordinales[i]} número"
    read -r lista_cardinales[i]
done

echo "La lista ordenada de la siguiente"
printf '%s\n' "${lista_cardinales[@]}" | sort -rn 
}

# Cuenta cantidad de tipos de archivos dentro de un directorio
function contar_cantidad_archivos() {
read -p 'Ingrese una ruta cualquiera por ejemplo, "/etc/": ' directory
find $directory -type d -exec echo Directorios \; -o -type l -exec echo Softlinks \; -o -type f -links +1 -exec echo Hardlinks \; -o -type f -exec echo Archivos \; | sort | uniq -c
}

clear
echo "Konichiwa $USER san"
echo -e "\n"
PS3='Elija una de las opciones: '
Opciones=("Fibonacci" "Inversión de Número Entero" "Palíndromo" "Cantidad Lineas Archivo" "Ordenar Cinco Números Enteros" "Cantidad de Archivos por Tipo" "Salir")
select opcion in "${Opciones[@]}"
do
    case $opcion in
        "Fibonacci")
            echo "1.Pedir un numero entero y mostrar esa cantidad de elementos de la sucesion de Fibonacci."
            fibonacci
            ;;
        "Inversión de Número Entero")
            echo "2.Pedir un numero entero y mostrar por pantalla ese numero en forma invertida."
            numero_entero_invertido
            ;;
        "Palíndromo")
            echo "3.Pedir una cadena de caracteres y evaluar si es palindromo o no."
            palindromo
            ;;
        "Cantidad Lineas Archivo")
            echo "4.Pedir el path a un archivo de texto y mostrar por pantalla la cantidad de lineas que tiene."
            cantidad_lineas_archivo
            ;;
        "Ordenar Cinco Números Enteros")
            echo "5.Pedir el ingreso de 5 numeros enteros y mostrarlos por pantalla en forma ordenada."
            ordenar_cinco_enteros
            ;;
        "Cantidad de Archivos por Tipo")
            echo "6.Pedir el path a un directorio y mostrar por pantalla cuantos archivos de cada tipo contiene (No se tenga en cuenta ./ y ../)."
            contar_cantidad_archivos
            ;;
        "Salir")
            clear
            echo "Sayonara $USER"
            break
            ;;
        *) echo "$REPLY es una Opción Inválida";;
    esac
done
