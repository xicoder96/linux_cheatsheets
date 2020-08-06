## Reversing the VKSI2000 Hand-Held Trading Device

by FOX PORT 

-------| 0. Table Of Contents

––•–√\/–•–– 1. Introduction
––•–√\/–•–– 2. Reversing Device Hardware
––•–√\/–•–– 3. REDACTED
––•–√\/–•–– 4. AVR Assembly
––•–––––•–––––• Assembly Language
––•–––––•–––––• AVR
––•–––––•–––––• Program Structure
––•–√\/–•–– 5. The HHT Device
––•–√\/–•–– 6. What The HHT Does
––•–√\/–•–– 7. The FIX Protocol
––•–––––•–––––• Encoding
––•–––––•–––––• Messages
––•–––––•–––––• Order Management
––•–––––•–––––• Security
––•–√\/–•–– 8. Next Steps

-------| 1. Introduction

The VKSI2000 is a handheld trading system (HHT) that provides traders 
with a "secure" RF connection to a trading exchange. Direct connections 
to trading exchanges are hard to come by, and so I've been pawing my way 
through this weird device for the last year in an effort to research 
the security of trading and exchanges.

From the outside, the HHT is deceptively simple. It's like a 1995 Palm 
Pilot trading interface. You enter ticker symbols; the device receives 
OTA price information and tracks your the number of shares you own (your 
"position"). You can enter a number of shares and execute buys or sells 
at the current market price. That's it.
                                                    
                                                    
       ┌───────────────────────────────────────────┐
       │                                           │
       │                                       ◐  │
       │                                           │
       │                                           │
       │ ┌────────────────┐┌───┐┌───┐   ┌───┐┌─┬─┐ │
       │ │      FCOJ      ││ $ ││ # │   │ # ││ │ │ │
       │ └────────────────┘└───┘└───┘   └───┘└─┴─┘ │
       │ ┌────────────────┐┌───┐┌───┐   ┌───┐┌─┬─┐ │
       │ │      FCOJ      ││ $ ││ # │   │ # ││ │ │ │
       │ └────────────────┘└───┘└───┘   └───┘└─┴─┘ │
       │ ┌────────────────┐┌───┐┌───┐   ┌───┐┌─┬─┐ │
       │ │      FCOJ      ││ $ ││ # │   │ # ││ │ │ │
       │ └────────────────┘└───┘└───┘   └───┘└─┴─┘ │
       │ ┌────────────────┐┌───┐┌───┐   ┌───┐┌─┬─┐ │
       │ │      FCOJ      ││ $ ││ # │   │ # ││ │ │ │
       │ └────────────────┘└───┘└───┘   └───┘└─┴─┘ │
       │ ┌────────────────┐┌───┐┌───┐   ┌───┐┌─┬─┐ │
       │ │      FCOJ      ││ $ ││ # │   │ # ││ │ │ │
       │ └────────────────┘└───┘└───┘   └───┘└─┴─┘ │
       │                                           │
       │ ┌──────────────────────────────────────┐  │
       │ │██████████████████████████████████████│  │
       │ │██████████████████████████████████████│  │
       │ │██████████████████████████████████████│  │
       │ │██████████████████████████████████████│  │
       │ │██████████████████████████████████████│  │
       │ └──────────────────────────────────────┘  │
       │                                           │
       └───────────────────────────────────────────┘
                                                    
                                                    
But lurking inside the 1995 handheld UI is a more sophisticated 
1997-grade trading engine. To get to it, we need to reverse the device, 
get our code running on it, and, if need be, jailbreak it.
                                         
-------| 2. Reversing The Device Hardware

Not hard. 

The device has a programming port on the back, which we assume is used 
to provision them for specific companies. It accepts an 8-pin connector. 
For our purposes, this is simply a standard serial connector.

Serial ports are usually easy to reverse[1]. This one isn't an 
exception. Pop the plastic shell of the HHT open and a multimeter finds 
a ground pin (marked G) by continuity testing. Power the device on and 
off and watch the pins, and transmit (T) is easy to spot.

I rolled the dice and assumed 115200 8N1 (don't overthink it!), and "cu" 
and some trial and error found the receive pin.
                                          
                                          
  ┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐┌───┐
  │ ? ││ R ││ T ││ ? ││ ? ││ ? ││ ? ││ G │
  └───┘└───┘└───┘└───┘└───┘└───┘└───┘└───┘
         ▲    ▲                        ▲  
         └────┴──────────────────┬─────┘  
                                 │        
                         ┌ ─ ─ ─ ─ ─ ─ ─ ┐
                          connect to UART 
                         └ ─ ─ ─ ─ ─ ─ ─ ┘
                                 │        
                                 │        
                                 │        
                                 ▼        
                                          
                                USB       
                                          
Restart it with everything hooked up, and we get:

   VKSI2000 v1.9p392 [booting]
   FIELD SUPPORT ONLY UNAUTHORIZED USE PROHIBITED
   (c) 1993-2015 35=G Technologies / All Rights Reserved
   ---------------------------
   
Fun times!

It gets better. There's no command prompt or help. But probe the 
connection and you'll find that "$" is a special character, which 
generates cryptic-looking "E ##" messages. Sure enough: there's a GDB 
remote debugging stub running on the port.

I've built a version of GNU binutils on my machine with every 
conceivable architecture enabled. Using the debug stub, I dumped the 
memory in hex into a file and decoded it into raw binary. There are two 
runs of data, separated by a sea of NUL bytes, together adding up to 
around 32k. Just for convenience sake I "objcopy"'d it into an ELF file, 
and then starting with X86 and working my way down the common 
architectures tried to find one for which "objdump -d" printed something 
intelligible.

It's AVR. Not a big surprise. I had some trouble making the jump offsets 
work out, until it occurred to me to split the file in half and 
ELF-encode just the second half. AVR has a split address space for code 
and data.

-------| 3. This Section Removed

Legal at 35=G Inc will allow me to publish this article only if this 
section is not present.

-------| 4. AVR Assembly

To do anything interesting with an embedded system like this, we need to 
understand basic assembly language programming.

--[ assembly programming ]-----------

Assembly language is more intimidating than it is hard. I can sum it up 
for you very briefly:

* You're given 8-32 global variables of fixed size to work with, called 
"registers".

* There are special registers. The most important is the "Program 
Counter", which tells the CPU which instruction we're executing next. 
Every time we execute an instruction, we advance the program counter.

* Virtually all computation is expressed in terms of simple operations 
on registers.

* Real programs need many more than 32 1-byte variables to work with.

* What doesn't fit in registers lives in memory.

* Memory is accessed either with loads and stores at addresses, as if it 
were a big array, or through PUSH and POP operations on a stack.

* Memory is to an assembly program what the disk is to a Ruby program: 
you pull things out of memory into variables, do things with them, and 
eventually put them back into memory.

* Control flow is done via GOTOs --- jumps, branches, or calls. The 
effect of these instructions is to alter the program counter directly.

* A jump is just an unconditional GOTO.

* Most operations on registers, like addition and subtraction, have the 
side effect of altering status flags, like "the last value computed 
resulted in zero". There are just a few status flags, and they usually 
live in a special register.

* Branches are just GOTOs that are predicated on a status flag, like, 
"GOTO this address only if the last arithmetic operation resulted in 
zero".

* A CALL is just an unconditional GOTO that pushes the next address on 
the stack, so a RET instruction can later pop it off and keep going 
where the CALL left off.

--[ avr assembly ]-----------

Now, we can fill in some of the details for the AVR architecture in use here:

* AVR gives us 32 1-byte registers.

* AVR is a RISC-style architecture, so it isolates computation to 
registers; we get a "load", "store", "push", and "pop" and little else 
that directly touches memory.

* There's a stack, that grows downwards: the bottom of the stack is at a 
high address, and each PUSH decrements the stack pointer.

* This AVR chip gives us 16k of memory.

* The AVR status flags live in SREG, and are (C)arry, (Z)ero, 
(N)egative, o(V)erflow, (S)igned, (H)alf-carry, (T), and (I)nterrupts. 
C, Z, N, V, and S are the important ones.

--[ program structure ]-----------

99.9% of the time, when we're reversing assembly code, we're looking at 
the output of a C compiler. That's especially likely an on embedded 
architecture like AVR. Which is good news, because it lets us make 
simplifying assumptions about the code:

* The program is divided into functions. 

* We can spot functions because they have a common "prologue". In 
AVR-GCC, for instance, a function that wants to use any of the registers 
between 2 and 17 must save those registers, and will always do so on the 
stack, which in turn adjusts the stack pointer.

* Functions are divided into basic blocks. A basic block is a run of 
instructions that concludes in a GOTO. The basic blocks of a function 
allow us to look at it like a flow-chart instead of a long list of 
individual instructions.

We can easily break a function into basic blocks by hand. Here's a 
simple example:

    ; r30 = r22 (16 bits, so r31 = r23, too)
    2042 : movw	r30, r22
    ; r26 = r24
    2044 : movw	r26, r24
    ; r0 = memory[Z++]
    2046 : ld	r0, Z+
    ; memory[X++] = r0
    2048 : st	X+, r0
    ; r0 = r0 AND r0 
    204a : and	r0, r0
    ; if SREG[Z] == 1, goto -8
    204c : brne	.-8	
    ; return
    204e : ret

... now, without the annotation, start with basic block 0: 

0:
    2042 : movw	r30, r22
    2044 : movw	r26, r24
    2046 : ld	r0, Z+
    2048 : st	X+, r0
    204a : and	r0, r0
    204c : brne	.-8	
    204e : ret

... now the ends of basic blocks by looking for jumps:

0:
    2042 : movw	r30, r22
    2044 : movw	r26, r24
    2046 : ld	r0, Z+
    2048 : st	X+, r0
    204a : and	r0, r0
    204c : brne	.-8	
1:
    204e : ret

... now make the TARGETS of any jumps the beginning of their own basic 
blocks:

0:
    2042 : movw	r30, r22
    2044 : movw	r26, r24
1:
    2046 : ld	r0, Z+
    2048 : st	X+, r0
    204a : and	r0, r0 
    204c : brne	.-8	
2: 
    204e : ret

... and now note which blocks connect to which, and make some notes:

0: 1 (prologue)
1: 1, 2
2: (return)

Looking at an assembly program this way, we can see that control flow 
isn't that much different than that of a Ruby program. We have 
conditionals ("ifs") and we have loops.

We can spot many "ifs" by looking for (1) conditional branches that (2) 
ultimately jump forward (this isn't always true, but it's a good 
heuristic).

We can spot "while" loops by looking for conditionals with backwards 
jumps.

A modern programming language might have for-loops, iterators, 
exceptions, switches, and pattern matching. But on the metal, we can 
express all those concepts with "if" statements and "while" loops.

The function we've been looking at copies a NUL-terminated string. If it 
isn't clear why:

1. It's built around a single simple loop

2. The loop reads a value from memory and then writes that value 
somewhere else in memory.

3. The loop concludes by AND'ing the value it loads with itself. A value 
AND'd against itself is that value; because AND is cheap, "X AND X" is 
an idiom for "check if this value is zero". If it is, the Z flag will 
get set.

4. The loop concludes, by NOT branching backwards but instead proceeding 
forward to the return, if the Z flag is set.

If you'd like practice, here's a more complicated function:

    2050 : movw	r30, r22
    2052 : ld	r21, Z+
    2054 : and	r21, r21
    2056 : breq	.+42
    2058 : movw	r22, r30
    205a : movw	r26, r24
    205c : ld	r20, X+
    205e : cp	r20, r21
    2060 : cpse	r20, r1
    2062 : brne	.-8	
    2064 : brne	.+22	
    2066 : movw	r24, r26
    2068 : ld	r0, Z+
    206a : and	r0, r0
    206c : breq	.+18	
    206e : ld	r20, X+
    2070 : cp	r20, r0
    2072 : cpse	r20, r1
    2074 : breq	.-14	
    2076 : movw	r30, r22
    2078 : cpse	r20, r1
    207a : rjmp	.-34	
    207c : ldi	r24, 0x01
    207e : ldi	r25, 0x00
    2080 : sbiw	r24, 0x01	
    2082 : ret

Just remember that branches work by adding or subtracting from the 
program counter AFTER decoding the instruction; in effect, you're 
offsetting from the instruction FOLLOWING the branch.

--[ more on avr ]-----------

The AVR instruction set is available online; you can usually Google for 
"avr CPSE" to see a page for the CPSE instruction. It's long enough that 
I won't include it all here, but I'll give you a brief summary of its 
contours:

You've got your math instructions:

ADC, ADD, ADIW, AND, ANDI, ASR, EOR, INC, LAS, LAT, LSL, LSR, ROL, ROR, 
DEC, OR, NEG, SUB, SUBI

Each of those will take a pair of registers, perform an operation on 
both, and store the result back to the first argument. So "ADD r2, r3" 
means "R2 = R2 + R3".

You've got your PUSH, your POP, and your JMP.

You've got your branches, each of which checks a status flag or pattern 
of status flags and either does or does not jump. BREQ and BRNE, which 
check whether the Z flag is or isn't set, is the most common of these.

BRBC, BRBS, BRCC, BRCS, BREQ, BRGE, BRHC, BRHS, BRID, BRIE, BRLO, BRLT, 
BRMI, BRNE, BRPL, BRSH, BRTC, BRTS, BRVC, BRVS

You've got your instructions that set or clear flags in SREG explicitly; 
for instance, SEV (SE)ts the o(V)erflow flag:

SEC, SEH, SEI, SEN, SER, SES, SET, SEV, SEZ, CLC, CLH, CLI, CLN, CLR, 
CLS, CLT, CLV, CLZ

You've got your instructions that call functions, or return from them. A 
CALL is like a GOTO that pushes a return address onto the stack (it's a 
"JUMP PUSH"), and a RET is a GOTO that pops the address to go to from 
the stack (it's a "POP JUMP").

CALL, ICALL, RCALL, RET

You've got your loads and your stores:

LD[XYZ][+], ST[XYZ][+]. 

Loads and stores are relative to the X, Y, and Z registers, which are 
aliases for the 16 bit register pairs starting at r26, r28, and r30 
respectively (r30 is an alias for Z). Some loads and stores increment 
the address after finishing, so they can be called repeatedly to (for 
instance) copy data.

There are a few funkier instructions that have to do with I/O, or with 
space-saving, but when you come across them, you can just Google them.

-------| 5. The HHT Device

Here's what I've worked out about what the board in this HHT looks like:
                                                  
                                     ┌ ─ ─ ─ ─ ─ ┐
                                     │    RF     │
                                     └ ─ ─ ─ ─ ─ ┘
                                           ▲      
                                           ▼      
      ╔═══════════╗   ╔═══════════╗  ╔═══════════╗
      ║ mystery   ║   ║ app       ║  ║ network   ║
      ║ avr       ║   ║ avr       ║  ║ avr       ║
      ║           ║   ║           ║  ║           ║
      ╚═══════════╝   ╚═══════════╝  ╚═══════════╝
            ▲               ▲              ▲      
            └───────────────┼──────────────┘      
                            ▼                     
                   ┌ ─ ─ ─ ─ ─ ─ ─ ─              
                   │ i/o controller |              
                   └ ─ ─ ─ ─ ─ ─ ─ ─              
                            ▲                     
                   ┌────────┴───────┐             
                   │                │             
                   ▼                │             
             ┌───────────┐    ┌ ─ ─ ─ ─ ─ ┐       
             │           │    │           │         
             │ flash     │    │ interface │       
             │           │    │           │         
             └───────────┘    └ ─ ─ ─ ─ ─ ┘       

There are three AVR processors in the device. I'll call them "app", 
"mystery", and "network".

The "network" processor drives the RF chipset; it's the device's link to 
the outside world.

The "app" processor handles requests from the user interface.

The AVR chips, storage, RF chipset, and interface components are linked 
by a bus, which is managed by an I/O controller.

So in a sense, the HHT has a built-in LAN. The network uses what appears 
to be a trivial protocol, with an address byte, a length byte, and a 
variable-sized payload.
                                                   
     ┌──────┐ ┌──────┐ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
     │ ADDR │ │ LEN  │ │ (VARLEN) PAYLOAD         │ 
     └──────┘ └──────┘ └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 

Now the bad news: we can dump and debug only the "app" processor. No 
combination of pins I can find bring up a console, text output, or a 
debug stub on the other two devices. Nor have I taken the time to figure 
out how to dump the whole flash.

What we can see are the messages running between the processors. 
Whatever the bus is, it's close enough to SPI (and uses the AVR SPI 
programming interface) that a SPI bus sniffer gives us something 
intelligible.

-------| 6. What The HHT Does

By sniffing the bus while fiddling with the UI, we can get a sense of 
how it works:
                              
        ┌ ─ ─ ─ ─ ─ ┐         
        │ interface │◀───────┐
        └ ─ ─ ─ ─ ─ ┘        │
              │              │
              ▼              │
        ╔═══════════╗        │
        ║ app       ║        │
        ║ avr       ║        │
        ║           ║        │
        ╚═══════════╝        │
              │              │
       ┌──────┴─────┐        │
       ▼            ▼        │
 ╔═══════════╗┌───────────┐  │
 ║ mystery   ║│           │  │
 ║ avr       ║│ SPI flash │──┘
 ║           ║│           │   
 ╚═══════════╝└───────────┘   
       │                      
       └──────┐               
              ▼               
        ╔═══════════╗         
        ║ network   ║         
        ║ avr       ║         
        ║           ║         
        ╚═══════════╝         
              │               
              ▼               
    ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐     
    │     exchange      │     
    └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘     

Enter a ticker symbol into the UI, and the "app" processor generates a 
JSON message:

    { 
      msgno: 293,
      cmd: "subscribe",
      ticker: "FCOJ",
    }

(I've left off the I/O controller, and, as is true of all messages in 
this system, it's framed with the I/O controller's protocol).

JSON goes into the "mystery" processor. FIX protocol comes out of it --- 
a quote-request message.

FIX goes into the "network" processor, and, presumably, comes out the 
other end and is routed to the exchange.

-------| 7. The FIX Protocol

FIX is the TCP/IP of money. It's the lowest common denominator standard 
protocol used at trading exchanges (and private financial networks) 
around the world.

I have good news and bad news about FIX.

The good news is: as protocols go, FIX is brain-dead simple. It is 
almost, but not quite, just a weird variant of CSV. You can bang out a 
FIX implementation in less than an hour.

The bad news is: every system that uses FIX uses a slightly different 
dialect of FIX, so knowing how to speak FIX to one exchange won't 
automatically let you speak it to another.

--[ fix encoding ]-----------

FIX messages are bags of key-value pairs. If you understand JSON, you 
understand a far more sophisticated protocol than FIX.

The keys in FIX are called "tag numbers". They're numeric, and encoded 
in ASCII. There are a bunch of standard tags, such as for message 
encoding and basic commands, and then a zillion nonstandard tags in use 
at most exchanges.

Tags and values are separated by the equals sign. So, for instance, 
"666=foo" is a validly encoded tag.

Fields are virtually always 7-bit ASCII.

Fields in FIX are separated by the ASCII SOH character (that's 01h). SOH 
serves the same role as commas would in CSV. FIX is the only protocol I 
know of for which SOH is a metacharacter.

By convention, when writing pure-ASCII representations of FIX, we 
substitute the '|' character for SOH, which isn't printable.

--[ fix messages ]-----------

All FIX messages have a prologue and an epilog, which are composed of 
tags. The prologue has a version, a length, and a message type; the 
epilogue has a checksum.

Here's a sample FIX message.

8=FIX.4.1|9=103|35=D|34=3|49=JOHNQTRADER|52=20151120-
12:14:01|56=EXEC|11=271948103|21=1|38=10000|40=1|
54=1|55=FCOJ|59=0|10=215	

Less obnoxiously:

8=	FIX.4.1	    // (8) version
9=	103	    // (9) len
35=	D           // (35) type ("order")
34=	3	
49=	JOHNQTRADER	// (49) sendercompid
52=	20151120-12:14:01	
56=	EXEC	        // (56) targetcompid
11=	271948103	
21=	1
38=	5000	
40=	1
54=	1
55=	FCOJ	
59=	0
10=	062	    // (10) checksum

You can look up FIX tags on a bunch of different websites. I've called 
out the prologue, the epilogue, and the SenderCompId and TargetCompId 
tags (which are, respectively, the source and the destination of the 
message).

--[ fix orders ]-----------

FIX mostly exists to enter and manage orders into trading exchanges.

Clients create orders with ORDER messages. An order will have a SYMBOL 
field identifying what's being traded, an ORDERQTY field specifying how 
much of that thing to trade, a SIDE field specifying whether it's a buy 
or sell, an ORDERTYPE field specifying whether it's a market or limit 
order, and, for limit orders, a PRICE field.

Orders are tracked by two sets of identifiers, one managed by the 
client, the other by the exchange.

The CLORDID field is the client's order number. The exchange echoes back 
this identifier on messages about that order. It's the client's job to 
make sure this number is unique, which is good news for us, because it 
means order IDs are usually just monotonic counters.

The ORDERID field is the exchange's identifier for the order.

Once an order is submitted, the client gets EXECUTION REPORT messages to 
update them on the status of their order.

Depending on the exchange, you might be able to use either CLORDID or 
ORDERID to CANCEL or CANCEL/REPLACE an order.

Orders are uniquely identified by the tuple [SenderCompId, CLORDID, 
ORDERID].

--[ fix security ]-----------

The short answer is there is mostly no such thing.

FIX defines a LOGON message (type 'A'). There's a "Password" tag, but if 
you're lucky, your target system won't even use it; you start a session 
by connecting to a FIX endpoint and sending a LOGON message with just 
your SenderCompId.

Over the years, there have been several attempts at standards for 
security features in FIX, ranging from better authentication to message 
encryption. Few exchanges use these features. Trading software 
developers are obsessed with message processing speed, and they're 
skeptical about security.

A once common security pattern at exchanges was for connections to be 
routed over private circuits, through which connectivity was only 
provided to a single "gateway", which validated SenderCompId. If you 
attempted to connect to Lehman Brothers FIX gateway using Bear Stearns' 
SenderCompId, your connection would be rejected.

The better exchanges do have passwords on their FIX gateways. But the 
performance of a FIX login is especially important (there's often a race 
to start trading at the beginning of a session) and so passwords are 
short and guessable.

Once logged in, there are three other big security issues.

The first and most obvious is that the market runs on software written 
by humans, just like everything else. The pre-authentication attack 
surface of an exchange is relatively small (FIX is a very simple 
protocol to parse). But the post-auth attack surface can be enormous.

The second issue is that many markets rely on anonymity in order 
handling. Clients of the market can see orders once they hit the books, 
but they can't see who owns the order. Being able to learn the trading 
intent of a high-volume trader can be very lucrative. There are also 
trading strategies that rely on orders that aren't shown on the books 
until some trigger happens. That means all the message handling at the 
exchange needs to be careful not to leak information to us^H^Hmalicious 
clients.

Finally and most importantly, the integrity of the market depends on us 
not being able to manipulate other people's orders. That means:

[+] we shouldn't be able to submit orders with someone else's 
SenderCompId

[+] we shouldn't be able to manipulate someone else's order using the 
exchange's ORDERID field unless we're the ones who submitted it

[+] we shouldn't be able to learn about valid ORDERIDs that we haven't 
submitted.

-------| 8. Where Do We Go Now?

We have a device that takes the old rules of securing an exchange --- 
"security doesn't matter because everything's happening over leased 
lines" --- and throws them out the window.

By getting our own code running on it, we should be able to get direct 
access to FIX messaging.

We're at a point in the narrative where I should probably stop talking.

But, let's say for a second that I wasn't just a researcher, and I was 
looking to take this attack vector as far as I could. What would my next 
steps be?

1. We control the app processor, using the debugger. But it doesn't look 
like the app processor can do much that the device UI can't already do. 
We should make sure that's the case.

2. We should figure out what's running on the network and "mystery" 
processors, and, obviously, try to get our own code running on them.

3. If we can pop the "mystery" processor, we should see how it and the 
network processor work to validate FIX messages. If the "mystery" 
processor does all the FIX validation, and we can take it over, maybe we 
don't even care what's running on the network processor.

4. Once we get arbitrary FIX messaging, we want to start poking at the 
exchange and figure out how to make money. Or, I mean, that's what you 
want to do. I'm just a researcher writing tfiles.

-------------------------

GREETZ: ratscabies, BioH, THE MESSiAH[SiN], vacuum

Brought to you by Triple Sec, Old Grand-Dad Bourbon, and my dog 
Reinforcements.




