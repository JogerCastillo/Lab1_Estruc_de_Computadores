.data
mensaje_pedir: .asciiz "Ingrese cuantos números desea comparar (min 3, max 5): "  # Mensaje para solicitar cantidad de números
mensaje_num: .asciiz "Ingrese un número: "  # Mensaje para solicitar un número
mensaje_mayor: .asciiz "El número mayor es: "  # Mensaje para mostrar el número mayor encontrado
salto: .asciiz "\n"  # Salto de línea (no se usa en este código)

.text
.globl main  # Define 'main' como una etiqueta global

main:
    # Imprimir mensaje para pedir la cantidad de números
    li $v0, 4  #imprimir el texto
    la $a0, mensaje_pedir  # Cargar la dirección del mensaje en $a0
    syscall  # Llamar al sistema para imprimir

    # Leer la cantidad de números a ingresar
    li $v0, 5  # Código de sistema para leer un número entero
    syscall  # Capturar la entrada del usuario
    move $t0, $v0  # Almacenar la cantidad de números en $t0

    # Inicializar variables
    li $t1, 0  # Contador del bucle (inicializado en 0)
    li $t2, -99999  # Variable para almacenar el número mayor (valor muy bajo inicial)

loop:
    # Si $t1 (contador) >= $t0 (cantidad de números a ingresar), salir del bucle
    bge $t1, $t0, fin

    # Imprimir mensaje para ingresar un número
    li $v0, 4  # Código de sistema para imprimir texto
    la $a0, mensaje_num  # Cargar la dirección del mensaje
    syscall  # Llamar al sistema para imprimir

    # Leer el número ingresado por el usuario
    li $v0, 5  # Código de sistema para leer un número entero
    syscall  # Capturar la entrada del usuario
    move $t3, $v0  # Almacenar el número ingresado en $t3

    # Comparar si el número ingresado es mayor que el almacenado en $t2
    ble $t3, $t2, continuar  # Si $t3 <= $t2, saltar a 'continuar'
    move $t2, $t3  # Si es mayor, actualizar $t2 con el nuevo número mayor

continuar:
    addi $t1, $t1, 1  # Incrementar contador
    j loop  # Repetir el bucle

fin:
    # Imprimir mensaje antes de mostrar el número mayor
    li $v0, 4  # Código de sistema para imprimir texto
    la $a0, mensaje_mayor  # Cargar la dirección del mensaje
    syscall  # Llamar al sistema para imprimir

    # Imprimir el número mayor encontrado
    li $v0, 1  # Código de sistema para imprimir un número entero
    move $a0, $t2  # Cargar el número mayor en $a0
    syscall  # Llamar al sistema para imprimir

    # Finalizar el programa
    li $v0, 10  # Código de sistema para salir del programa
    syscall  # Llamar al sistema para terminar

