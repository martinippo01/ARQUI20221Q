
section     .data
            number   db "%d", 10, 0 ; Declare variable for printing palindrome numbers.

section     .text
            global main
            extern printf           

main:       
            call cargo_tope
            
            
                  
start:      
            push  ecx               
            mov   ax, cx           
            mov   bx, 10            
            mov   cx, 0             

pdigits:    
            mov   dx, 0             
                                    
            div   bx                
                                    
            push  dx                
            inc   cx                
            cmp   ax, 0             
                                   
            je    cont              
            jmp   pdigits           
                                    
cont:       
            cmp   cx, 4            
            je    four             
            cmp   cx, 3             
            je    three             
            cmp   cx, 2             
            je    two               
            cmp   cx, 1            
            je    one              

four:       
            pop   ax               
            pop   bx               
            pop   cx               
            pop   dx              
            cmp   ax, dx           
            jne   nope             
            cmp   bx, cx            
            jne   nope           
            je    yep               

three:      
            pop   ax
            pop   bx
            pop   cx
            cmp   ax, cx
            jne   nope
            je    yep

two:        
            pop   ax
            pop   bx
            cmp   ax, bx
            jne   nope
            je    yep

one:        
            pop   ax                
            jmp   yep              
                                   

nope:       
            pop   ecx               
            dec   ecx               
            jnz   start            

yep:        
            pop   ecx               
            push  ecx              

            push  number            
            call  printf           
                   
                        
            pop   ecx             
            push  ecx             
            dec   ecx               
            jnz   start           
exit:       
            mov   ax, 1             
            mov   bx, 0            
                      
cargo_tope:
          mov ecx,0
          mov ebx,filename
          mov eax,5
          int 80h
          
	  mov edx,150
          mov ecx,buffer
          mov ebx, eax          
          mov eax,3
          int 80h 
          mov  ecx,30
          mov  edi,buffer
          mov  edx,arr
ciclo:    call atoi  
	  mov  ecx,eax
	  ret
atoi:
         mov eax,0
         push ebx
convert:
         movzx  esi, byte [edi]
         mov bl,byte [edi]
         test esi,esi
         je done  
         cmp bl," "
         je done
         cmp esi,48
         jl error
         cmp esi,57 
         jg error  
         sub esi,48
         imul   eax,10
         add eax,esi  
         inc edi
         jmp convert
error:   mov eax, -1
done:    pop ebx
         ret 	  
section  .data
         filename       db "tope.txt",0	  
section .bss

arr      resb 30
buffer   resb 150	  	
                                   
