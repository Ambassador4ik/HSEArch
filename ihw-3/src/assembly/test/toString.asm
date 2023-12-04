.data
    # Allocate space for the string representation of the integer
    # Assuming the maximum length of 10 digits for 32-bit integer and one for the null terminator
    str: .space 11

.text
    # Entry point
    .globl main
main:
    li t1, 10             # Temporary register t1 will be used to hold the divisor (10)
    la t2, str            # Load address of the string buffer into t2

    # Check if the integer is zero and handle it as a special case
    bnez a0, convert      # If a0 is not zero, jump to convert
    li t3, '0'            # Otherwise, just store '0'
    sb t3, 0(t2)          # Store '0' character in buffer
    sb zero, 1(t2)        # Store null terminator
    j done                # Conversion is done for zero

convert:
    # Prepare the stack to hold the digits in reverse order
    addi sp, sp, -12      # Make room on the stack for up to 10 digits + null terminator
    mv t3, sp             # Temp t3 will point to where we'll write our characters on the stack

    # Loop to extract digits from integer and convert to ASCII
atoi_loop:
    li t4, 10             # Load divisor
    remu a1, a0, t4       # a1 = a0 % 10 (remainder)
    divu a0, a0, t4       # a0 = a0 / 10 (quotient)

    addi a1, a1, 48       # Convert digit to ASCII code ('0' is 48 in ASCII)
    sb a1, 0(t3)          # Store ASCII character on the stack
    addi t3, t3, 1        # Move stack pointer up by 1

    bnez a0, atoi_loop    # If quotient is not zero, we still have digits to process

    # Add null terminator to the end of the digit characters on the stack
    sb zero, 0(t3)

    # Now copy the characters from the stack to our string buffer in reverse order
itoa_loop:
    lb a1, 0(sp)          # Load byte (character) from the stack into a1
    beqz a1, done         # If null terminator, we are done
    sb a1, 0(t2)          # Store byte (character) in the buffer

    addi sp, sp, 1        # Move stack pointer back up to the next character
    addi t2, t2, 1        # Move buffer pointer to the next position
    j itoa_loop

done:
    # At this point, the integer has been converted to a string and stored at 'str' memory location.
    # 't2' points to the end of the string (after the null terminator).
    # Your program would go on to do whatever is needed with the string.

    # Exit example - should be replaced with desired program behavior
    li a7, 10             # Exit system call number for RARS
    ecall                 # Make the system call to exit