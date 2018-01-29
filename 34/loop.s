 #VARIABLES:	The registers have the following uses:
 #
 # 		%edi - Holds the index of the data item being examined
 # 		%ebx - Largest data item found
 # 		%eax - Current data item
 #
 # 		The following memory locations are used:
 #
 # 		data_items - contains the item data.  A 0 is used
 #              to terminate the data
 #

.section .data

data_items:	#These are the data items

.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
.section .text
.globl _start

_start:
	movl $0, %edi				# move 0 into the index register
	movl data_items(,%edi,4), %eax		# load the first byte of data
	addl $1, %eax				# add 1 to the %eax.
	movl %eax, %ebx				# since this is the first item, % eax is
						# the biggest


start_loop:					# start loop
	cmpl $0, %eax				# check to see if we've hit the end
	je loop_exit				# if the element is 0 that means we hit the end.
						# So, exit from the loop.
	incl %edi				# load next value
	movl data_items(,%edi,4), %eax		# the next value come into the %eax register
	movl %eax, %ecx				# create %ecx register. Take the address of %eax
						# and give this address to the %ecx register.
						# So, they are pointing the same adress now.
	addl $1, %ecx				# Add 1 to the %ecx register.
	movl %ecx, data_items(,%edi,4)		# Change the value of vurrent list element
						# with current %ecx register.
	cmpl %ebx, %ecx				# compare values
	jle start_loop				# jump to loop beginnig if the new
						# one isn't bigger
	movl %ecx, %ebx				# move the value as the largest
 	jmp start_loop				# jump to loop beginning
loop_exit:
						# %ebx is the status code for the exit system call
						# and it already has the maximum number
	movl $1, %eax				#1 is the exit() syscall
	int  $0x80

