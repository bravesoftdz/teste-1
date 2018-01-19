
print(" ---------------------------------------------------------")
print("|                      CALCULADORA                        |")
print("|--------------->Opções                                   |")
print("|-> 1 - Soma                                              |")
print("|-> 2 - Multiplcação                                      |")
print("|-> 3 - Divisão                                           |")
print("|-> 4 - Subtração                                         |")
print("|                                                         |")
print("|                                                         |")
print(" ---------------------------------------------------------")

print("Digite o primeiro valor: ")
valor1 = int(input())

print("Digite o segundo valor: ")
valor2= int(input())

print("Digite a operação que deseja realizar: ")
operacao= int(input())

inicio
if operacao == 1:
    resultado = valor1 + valor2
    print(resultado)
    
if operacao == 2:
    resultado = valor1 * valor2
    print(resultado)
    
if operacao == 3:
    resultado = valor1 / valor2
    print(resultado)
    
if operacao == 4:
    resultado = valor1 - valor2
    print(resultado)
    
if operacao > 4:
    inicio
    
