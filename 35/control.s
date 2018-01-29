.section .data

data_items:	#These are the data items

.long 3,10,34,222,45,75,54,34,44,33,22,11,66,0
.section .text
.globl _start

_start:
	movl $0, %edi				#index points the first($0) eleemnt now
						#increase it to compare with other eelements
	movl data_items(,%edi,4), %eax		#get the firts element with one byte form the list
	cmpl $10, %eax				#compare the element with 10
	jg secondisbigger			#if the secondone is bigger jump to the secondisbigger label
	movl $0, %ebx				#otherwise, the output will be 0
	jmp exit				#jump to the exit label

secondisbigger:
	movl %eax, %ebx				#the output will be the element which is coming
						#from the list

exit:
					# %ebx is the status code for the exit system call
					# and it already has the maximum number
	movl $1, %eax			#1 is the exit() syscall
	int $0x80
