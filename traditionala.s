.data
n: .space 4
a: .space 4
matrix: .space 40000
sub: .space 40000
index: .long 0
jndex: .long 0
scan: .asciz "%ld\n"
print: .asciz "%ld "
noua: .asciz "\n"
determinantu: .asciz "Determinantul matricii de mai jos este %ld \n"

.text

.global main


determinant:
	pushl %ebp
	mov %esp,%ebp
	pushl %ebx
	pushl %edi
	pushl %edx
	subl $28,%esp
	
	movl 8(%ebp),%edi
	movl 12(%ebp),%edx
	
	movl $2,%eax
	cmp %eax,%edx
	jne els
	
	movl $0,%eax
	movl (%edi,%eax,4),%ebx
	
	movl $1,%eax
	movl $0,%edx
	mull 12(%ebp)
	addl $1,%eax
	
	movl (%edi,%eax,4),%ecx
	movl %ebx,%eax
	movl $0,%edx
	mull %ecx
	
	movl %eax,%edx
	
	movl $1,%eax
	movl (%edi,%eax,4),%ebx
	
	movl $1,%eax
	movl $0,%edx
	mull 12(%ebp)
	
	movl (%edi,%eax,4),%ecx
	
	movl %ebx,%eax
	movl $0,%eax
	mull %ecx
	
	subl %eax,%ebx
	movl %ebx,%eax
	
	jmp out
	
	els:
	
	movl $1,-32(%ebp)
	
	for_x:
	
		cmp -16(%ebp),%edx
		je schimb
		movl $-1,-36(%ebp)
		movl $0,-20(%ebp)
		for_ii:
			cmp -20(%ebp),%edx
			je xPP
			movl $0,-40(%ebp)
			movl $0,-24(%ebp)
			for_jj:
				cmp -24(%ebp),%edx
				je iPP
				movl -16(%ebp),%ebx
				movl -24(%ebp),%ecx
				cmp %ebx,%ecx
				je sub_sch
				movl -20(%ebp),%ebx
				cmp $0,%ebx
				je sub_sch
				revin:
				incl -24(%ebp)
				jmp for_jj
			
			sub_sch:
				push %edx
				movl -20(%ebp),%eax
				movl $0,%edx
				mull 12(%ebp)
				
				addl -24(%ebp),%eax
				movl 8(%ebp),%edi
				movl (%edi,%eax,4),%ecx
				
				
				movl -36(%ebp),%eax
				movl $0,%edx
				mull 12(%ebp)
				
				addl -40(%ebp),%eax
				lea sub,%edi
				movl %ecx,(%edi,%eax,4)
				pop %edx
		
				incl -40(%ebp)
				jmp revin	
			iPP:
			incl -36(%ebp)
			incl -20(%ebp)
			jmp for_ii
			
			xPP:
			
			push %ecx
			movl n,%ecx
			subl $1,%ecx
			
			push %ecx
			push $sub
			call determinant
			addl $8,%esp
			pop %ecx
			
			push %eax
			movl -16(%ebp),%eax
			movl 8(%ebp),%edi
			movl (%edi,%eax,4),%ecx
			pop %eax
			
			push %edx
			movl $0,%edx
			mull %ecx
			
			movl $0,%edx
			mull -32(%ebp)
			
			addl %eax,-28(%ebp)
			pop %edx
			
			
			
			
			incl -16(%ebp)
			jmp for_x
			
	
	schimb:
		movl -32(%ebp),%eax
	out:
	addl $28,%esp
	pop %edx
	pop %edi
	pop %ebx
	pop %ebp
	ret
	
	

main:
	push $n
	push $scan
	call scanf
	addl $8,%esp
	
	movl n,%ecx
	
	for_index:
		cmp index,%ecx
		je afis
		movl $0,jndex
		for_jndex:
			cmp jndex,%ecx
			je ipp
			
			push %ecx
			
			push $a
			push $scan
			call scanf
			addl $8,%esp
			
			pop %ecx
			
			movl index,%eax
			movl $0,%edx
			mull n
			addl jndex,%eax
			
			lea matrix,%edi
			movl a,%ebx
			movl %ebx,(%edi,%eax,4)
			
			
			incl jndex
			jmp for_jndex
		ipp:
		incl index
		jmp for_index	
	
	
	afis:
	
		push n
		push $matrix
		call determinant
		addl $8,%esp
		
				push %eax
				push $determinantu
				call printf
				addl $8,%esp
		
		movl $0,index
		for_i:
			movl n,%ecx
			cmp index,%ecx
			je exit
			movl $0,jndex
			for_j:
				cmp jndex,%ecx
				je ip
				
				movl index,%eax				
				movl $0,%edx
				mull n
				addl jndex,%eax
				
				lea matrix,%edi
				movl (%edi,%eax,4),%ebx
				
				
				push %ecx
				
				push %ebx
				push $print
				call printf
				addl $8,%esp
			
				pushl $0
				call fflush
				popl %ebx		
				
				pop %ecx
				
				incl jndex
				jmp for_j
				
		ip:
			movl $4, %eax
			movl $1, %ebx
			movl $noua, %ecx
			movl $2, %edx
			int $0x80
			
			
			incl index
			jmp for_i
	
			
			
	
	
	exit:
		mov $1,%eax
		xor %ebx,%ebx
		int $0x80
