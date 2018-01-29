
# Purpose:	program to illustrate how functions work
# 		this program will compute the value of 2^3 + 5^2.  Next it
# 		finds the maximal number.  You need to alter the code
# 		so that before it finds the maximal number, it puts the
# 		output from the power function into the first position in
# 		data_items.

.section .data

data_items:

.long 35, 67, 45, 35, 22, 54, 34, 44, 33, 22, 11, 66, 0
.section .text
.globl _start

_start:
	pushl $3        	#push second argument
	pushl $2        	#push first argument
	call power      	#call the function
	addl $8, %esp   	#move the stack pointer back
	pushl %eax      	#save the first answer before calling the next function
	pushl $3        	#push second argument
	pushl $6        	#push first argument
	call power      	#call the function
	addl $8, %esp   	#move the stack pointer back
	popl %ebx       	#the second answer is alerady in %eax.  We saved
                		#the first answer onto the stack, so now we can
                		#just pop it out into %ebx
	addl %eax, %ebx		#add them together.  The result is in %ebx

	movl $0, %edi
	leal data_items, %edx
	movl %ebx, (%edx)
	movl data_items (, %edi, 4), %eax
	movl %eax, %ebx

start_loop:
	cmpl $0, %eax
	je loop_exit
	incl %edi
	movl data_items(, %edi, 4), %eax
	cmpl %ebx, %eax
	jle start_loop
	movl %eax, %ebx
	jmp start_loop

loop_exit:
	movl $1, %eax
	int $0x80


# Purpose:	This function is used to compute the value of a number
#		raised to a power.
# Input:	first argument - the base number.
#		second argument - the power to raise it to
# Output:	will give the result as a return value
# Notes:	the power must be 1 or greater
# Variables:
#		%ebx - holds the base number
#		%ecx - holds the power
#		-4(%ebp) - holds the current result
#		%eax is used for temporary storage

.type power, @function
power:
	pushl %ebp              #save old base pointer
	movl %esp, %ebp         #make stack pointer the base pointer
	subl $4, %esp           #get room for our local storage
	movl 8(%ebp), %ebx      #put first argument in %eax
	movl 12(%ebp), %ecx     #put second argument in %ecx
	movl %ebx, -4(%ebp)     #store current result

power_loop_start:
	cmpl $1, %ecx           #if the power is 1, we are done
	je end_power
	movl -4(%ebp), %eax     #move the current result into %eax
	imull %ebx, %eax        #multiply the current result by base number
	movl %eax, -4(%ebp)     #store the current result
	decl %ecx               #decrease the power
	jmp power_loop_start    #run for the next power

end_power:
	movl -4(%ebp), %eax     #return value goes in %eax
	movl %ebp, %esp         #restore the stack pointer
	popl %ebp               #restore the base pointer
	ret

