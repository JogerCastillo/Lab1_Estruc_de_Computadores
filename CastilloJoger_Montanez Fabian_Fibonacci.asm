.data
    mensaje_pedir: .asciiz "Ingrese la cantidad de n\u00fameros de la serie Fibonacci: "  # Mensaje para pedir la cantidad de t\u00e9rminos
    mensaje_fib: .asciiz "Serie Fibonacci: "  # Mensaje para indicar el inicio de la serie
    salto: .asciiz "\n"  # Salto de l\u00ednea
    suma_msg: .asciiz "Suma de la serie: "  # Mensaje para la suma de la serie

.text
.globl main  

main:
    # Solicitar cantidad de t\u00e9rminos
    li $v0, 4  # Cargar c\u00f3digo de syscall para imprimir cadena
    la $a0, mensaje_pedir  # Cargar la direcci\u00f3n del mensaje en $a0
    syscall  # Llamar a syscall para imprimir mensaje

    # Leer la cantidad de t\u00e9rminos
    li $v0, 5  # Cargar c\u00f3digo de syscall para leer un entero
    syscall  # Llamar a syscall para leer el valor
    move $t0, $v0  # Guardar cantidad de t\u00e9rminos en $t0

    # Si n <= 0, salir
    blez $t0, fin  # Si la cantidad ingresada es menor o igual a 0, finalizar programa

    # Inicializar valores Fibonacci
    li $t1, 0  # F(0) = 0
    li $t2, 1  # F(1) = 1
    li $t3, 0  # Contador de iteraciones
    li $t4, 0  # Suma total

    # Mostrar mensaje de la serie
    li $v0, 4  # Cargar c\u00f3digo de syscall para imprimir cadena
    la $a0, mensaje_fib  # Cargar la direcci\u00f3n del mensaje en $a0
    syscall  # Llamar a syscall para imprimir mensaje

loop:
    # Si contador >= n\u00famero de t\u00e9rminos, salir del bucle
    bge $t3, $t0, imprimir_suma  # Si $t3 >= $t0, ir a imprimir_suma

    # Imprimir n\u00famero actual de Fibonacci
    li $v0, 1  # Cargar c\u00f3digo de syscall para imprimir entero
    move $a0, $t1  # Cargar el valor de Fibonacci en $a0
    syscall  # Llamar a syscall para imprimir el n\u00famero

    # Imprimir salto de l\u00ednea
    li $v0, 4  # Cargar c\u00f3digo de syscall para imprimir cadena
    la $a0, salto  # Cargar la direcci\u00f3n del salto de l\u00ednea en $a0
    syscall  # Llamar a syscall para imprimir el salto de l\u00ednea

    # Sumar el t\u00e9rmino actual ANTES de actualizar la serie
    add $t4, $t4, $t1  # Acumular la suma de los valores de Fibonacci

    # Calcular siguiente t\u00e9rmino de Fibonacci
    add $t5, $t1, $t2  # $t5 = $t1 + $t2 (nuevo Fibonacci)
    move $t1, $t2  # Desplazar valores: el segundo valor se convierte en el primero
    move $t2, $t5  # El nuevo Fibonacci se convierte en el segundo valor

    # Incrementar contador
    addi $t3, $t3, 1  # Incrementar el contador de iteraciones
    j loop  # Volver a la etiqueta loop para continuar el c\u00e1lculo

imprimir_suma:
    # Mostrar mensaje de la suma
    li $v0, 4  # Cargar c\u00f3digo de syscall para imprimir cadena
    la $a0, suma_msg  # Cargar la direcci\u00f3n del mensaje en $a0
    syscall  # Llamar a syscall para imprimir mensaje

    # Imprimir la suma total de la serie Fibonacci
    li $v0, 1  # Cargar c\u00f3digo de syscall para imprimir entero
    move $a0, $t4  # Cargar la suma total en $a0
    syscall  # Llamar a syscall para imprimir la suma

fin:
    # Terminar programa
    li $v0, 10  # Cargar c\u00f3digo de syscall para salir
    syscall  # Llamar a syscall para finalizar ejecuci\u00f3n  
