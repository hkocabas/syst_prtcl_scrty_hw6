 #VARIABLES:	The registers have the following uses:
 #
 # 		%edi - Holds the index of the data item being examined
 # 		%ebx - Largest data item found
 # 		%eax - Current data item
 #
 # 		The following memory locations are used:
 #
 # 		data_items - contains the item data.  A 0 is used
 # 		to terminate the data
 #

.section .data

data_items:		#These are the data items

.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
.section .text
.globl _start


_start:
	movl $0, %edi				# move 0 into the index register
	movl data_items(,%edi,4), %eax		# load the first byte of data
	movl %eax,%ecx				# get the %eax address and share it with %ecx
						# now, %ecx is pointing to the %eax register
	movl $225, %ecx				# assign 225 to the %ecx register
	leal (%ecx), %eax			# get the %ecx  value and assign it to the eax register
	movl %eax, %ebx				# since this is the first item, %eax is
						# the biggest


start_loop:					# start loop
	cmpl $0, %eax				# check to see if we've hit the end
	je loop_exit				# if we hit the last element in the array
						# then jump to the loop_exit
	incl %edi				# load next value
	movl data_items(,%edi,4), %eax		# the next value will be in %eax register
	cmpl %ebx, %eax				# compare values
	jle start_loop				# jump to loop beginning if the new
						# one isn't bigger
	movl %eax, %ebx				# move the value as the largest
 	jmp start_loop				# jump to loop beginning


loop_exit:
						# %ebx is the status code for the exit system call
						# and it already has the maximum number
    movl $1, %eax				# 1 is the exit() syscall
    int  $0x80
