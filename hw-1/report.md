# ДЗ #1
## Работа с RARS

### Программа #1
![](./images/1.png)
Видим, что `li` и `mv` - псевдокоманды: они реализованы через сложение с `x0`.

### Программа #2
![](./images/2.png)
Здесь добавляется псевдокоманда `la`.

### Программа #3
![](./images/3.png)
Проанализируем код программы:
```assembly
    .data
hello:
    .asciz "Hello, world!"
    .text
main:
    li a7, 4 # addi: immediate
    la a0, hello # auipc: upper immediate
    ecall
```

### Программа #4
![](./images/4.png)

### Программа #5
![](./images/5.png)

### Программа #6
![](./images/6.png)

### Системные вызовы
`addi`, `add`, `auipc`.
