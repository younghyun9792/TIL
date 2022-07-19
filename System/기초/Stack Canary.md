# **Stack Canary**

<br>

`Stack Canary`란 함수를 시작할 때 `Stack Buffer`와 `ret(return address)` 사이에 임의의 값(Canary)를 삽입하고, 함수를 종료할 때 해당 값이 변조되었을 시 프로그램을 종료하는 [`Stack Buffer Overflow`](./../취약점/Stack%20Buffer%20Overflow.md) 대응 기법이다.  

<br>

`Stack Buffer Overflow`로 `ret`을 조작하려면 반드시 `Canary` 값이 먼저 조작되므로, Canary 값을 모르는 공격자는 공격 시 Canary 값을 변조하게 되고, 함수의 종료 단계에서 프로그램을 강제로 종료시킨다.

<br>

> ### **Canary 이름의 유래**
> `Canary`는 `카나리아(Canary)`라는 새 이름에서 유래되었는데, 이 새는 19,20세기 때 일산화탄소 농도 측정 기술이 불가능할 때, 광부들은 일산화탄소에 민감하게 반응하는 이 새와 함께 들어가서 카나리아의 반응으로 일산화탄소 농도를 측정하여 위험할 시 대피했다.  
> 이런 역사적 배경으로인해 카나리아는 **"위험을 알려주는 새"** 라는 상징적 의미를 갖게 되었고, 소프트웨어를 출시, 업데이트 할 때 베타 테스트 용도로 공개된느 버전을 카나리 버전이라 부르는 이유도 여기에서 유래되었다.  
> 마찬가지로, 카나리 보호 기법도 반환 주소가 덮인 것(공격 당한 것)을 탐지하고 알려준다는 의미에서 `Canary`라는 이름이 붙여졌다.

<br><br>

---

<br>

### **Canary 비활성화**

<br>

gcc는 기본적으로 Stack Canary를 적용하여 컴파일하는데, 컴파일 옵션으로 `-fno-stack-protector` 옵션을 뒤에 추가해야 Canary 없이 컴파일할 수 있다.

이러고 길이가 긴 입력을 주면 반환 주소가 덮여서 `Segmentation fault`가 발생한다.

<br>

```bash
gcc -o no_canary canary.c -fno-stack-protector
./no_canary
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA...
Segmentation fault 
```

<br>

> ### **Segmentation fault란?**
> 프로그램이 허용되지 않은 메모리 영역에 접그늘 시도하거나, 허용되지 않은 방법으로 메모리 영역에 접근을 시도할 경우 발생한다.  
> 예를 들어 읽기 전용 영역에 쓰기를 시도하거나, 운영체제가 사용하는 영역에 다른 내용을 덮어 씌우려고 하는 경우 등이 있다.

<br><br>

카나리를 적용하여 컴파일하고 긴 입력을 주면 `Segmentation fault`가 아니라 `stack smashing detected`와 `Aborted`라는 에러가 발생하는데, 이건 스택 버퍼 오버플로를 탐지해 프로세스가 강제 종료되었음을 말한다.

<br>

```bash
$ gcc -o canary canary.c
$ ./canary
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*** stack smashing detected ***: <unknown> terminated
Aborted
```

<br><br>

카나리를 적용하기 전과 디스어셈블 결과를 비교하면 `main` 함수의 시작과 종료 부분에 아래와 같은 코드들이 추가되었다.

<br>

```asm
함수 시작 부분
0x00000000000006b2 <+8>:     mov    rax,QWORD PTR fs:0x28     
0x00000000000006bb <+17>:    mov    QWORD PTR [rbp-0x8],rax   
0x00000000000006bf <+21>:    xor    eax,eax   
```

<br>

```asm
함수 종료 부부
0x00000000000006dc <+50>:    mov    rcx,QWORD PTR [rbp-0x8]    
0x00000000000006e0 <+54>:    xor    rcx,QWORD PTR fs:0x28      
0x00000000000006e9 <+63>:    je     0x6f0 <main+70>                   
0x00000000000006eb <+65>:    call   0x570 <__stack_chk_fail@plt>
```

<br><br>

---

## **카나리 분석**

<br>

### **카나리 저장**

<br>


```
$ gdb -q ./canary
pwndbg> break *main+8
Breakpoint 1 at 0x6b2
pwndbg> run
 ► 0x5555555546b2 <main+8>     mov    rax, qword ptr fs:[0x28] <0x5555555546aa>
   0x5555555546bb <main+17>    mov    qword ptr [rbp - 8], rax
   0x5555555546bf <main+21>    xor    eax, eax
```

<br>

`main+8` 부분은 `fs:0x28`의 데이터를 읽어서 `rax`에 저장한다.  
`fs`는 `segment register`의 일종으로, 리눅스는 프로세스가 시작될 때 `fs:0x28`에 랜덤 값을 저장하는데, 즉 `rax`에는 리눅스가 생성한 랜덤 값이 저장된다.

<br>


코드를 한 줄 실행하면 `rax`에 다음과 같이 첫 바이트가 null 바이트인 8바이트 데이터가 저장되어 있다.

```
pwndbg> ni
   0x5555555546b2 <main+8>     mov    rax, qword ptr fs:[0x28] <0x5555555546aa>
 ► 0x5555555546bb <main+17>    mov    qword ptr [rbp - 8], rax
   0x5555555546bf <main+21>    xor    eax, eax
pwndbg> print /a $rax
$1 = 0xf80f605895da3c00
```

생성한 랜덤값은 `main+17`에서 `rbp-0x8`에 저장된다.

```
pwndbg> ni
   0x5555555546b2 <main+8>     mov    rax, qword ptr fs:[0x28] <0x5555555546aa>
   0x5555555546bb <main+17>    mov    qword ptr [rbp - 8], rax
 ► 0x5555555546bf <main+21>    xor    eax, eax
pwndbg> x/gx $rbp-0x8
0x7fffffffe238:	0x2619d41073c14900
```

<br><br>

### **카나리 검사**

<br>

이제 함수 종료 부분의 코드에 breakpoint를 설정하고 실행시켜보면, `main+50`은 `rbp-8`에 저장된 카나리를 `rcx`로 옮긴다.  
그리고, `main+54`에서 `rcx`를 `fs:0x28`에 저장된 카나리와 `xor`연산을 하는데, xor연산의 특성상 두 값이 동일하면 연산 결과가 0이 되고, 그렇게 될 시 `je`의 조건을 만족시켜서 `main`함수는 정상적으로 반환된다.  
하지만, 두 값이 동일하지 않으면 `__stack_chk_fail`이 호출되면서 프로그램이 강제로 종료된다.

<br>



```
pwndbg> break *main+50
pwndbg> continue
HHHHHHHHHHHHHHHH
Breakpoint 2, 0x00000000004005c8 in main ()
 ► 0x5555555546dc <main+50>    mov    rcx, qword ptr [rbp - 8] <0x7ffff7af4191>
   0x5555555546e0 <main+54>    xor    rcx, qword ptr fs:[0x28]
   0x5555555546e9 <main+63>    je     main+70 <main+70>
    ↓
   0x5555555546f0 <main+70>    leave
   0x5555555546f1 <main+71>    ret
```

<br>


여기서 입력을 16개의 H로 주면, `rbp-0x08`에 저장된 카나리 값이 버퍼 오버플로로 인해 `0x4848484848484848`이 된다.

<br>

```
pwndbg> ni
   0x5555555546dc <main+50>    mov    rcx, qword ptr [rbp - 8] <0x7ffff7af4191>
 ► 0x5555555546e0 <main+54>    xor    rcx, qword ptr fs:[0x28]
   0x5555555546e9 <main+63>    je     main+70 <main+70>
pwndbg> print /a $rcx 
$2 = 0x4848484848484848
```

<br>

`rbp-0x8(rcx)`과 `fs:0x28`의 값이 다르므로 `main+54`의 연산 결과가 0이 아니게 되고, `main+64`에서 `main+70`으로 jump하지 않고 `main+65`의 `__stack_chk_fail`을 실행한다.

<br>

`__stack_chk_fail` 함수가 실행될 경우 아래 메시지가 뜨면서 프로세스가 강제로 종료된다.

```
*** stack smashing detected ***: <unknown> terminated
Program received signal SIGABRT, Aborted.
```

<br><br><br>

---

<br>

## **카나리 생성 과정**

<br>

카나리 값은 프로세스가 시작될 때 `TLS`에 전역 변수로 저장되고, 각 함수마다 프롤로그와 에필로그(시작과 종료) 부분에서 이 값을 참조한다.

<br>


> ### **TLS란?**
> `TLS(Thread Local Storage)`는 스레드 별로 고유한 저장공간을 가질 수 있는 방법이다.
> 메모리의 할당은 `process`별로 이루어지게 되는데, 이런 구조 상 `Thread`는 동일한 메모리 구조를 공유하게 되고, `Thread`들은 같은 `Data` 영역을 공유하게 된다. 즉, `Process`의 모든 전역 변수는 모든 `Thread`가 공유하게 된다.  
> 하지만, `Thread`별로 고유한 전역변수가 필요한 경우가 있을 텐데, 이를 위해 `Stack`과 마찬가지로 고유한 영역을 제공하는 방법이다.

<br>

### **TLS의 주소 파악**

<br>

`fs`는 `TLS`를 가리키므로 `fs`의 값을 알면 TLS의 주솔르 알 수 있다. 하지만 리눅스에서 `fs`는 특정 syscall을 해야만 조회하거나 설정할 수 있다. gdb에서 다른 레지스터의 값을 보듯 `info register fs`나 `print $fs` 등의 방식으론 값을 알 수 없다.

<br>

그래서, `fs의`값을 설정할 떄 호출되는 `arch_prctl(int code, unsigned long addr)` syscall에 breakpoint를 설정하여 확인하면, 만약 이 syscall을 `arch_prctl(ARCH_SET_FS, addr)`의 형태로 호출할 시 `fs`의 값이 `addr`로 설정된다.

<br>

gdb에는 특정 이벤트가 발생하였을 떄 프로세스를 중지시키는 `catch`라는 명령어가 있다.  
이 명령어로 `arch_prctl`에 catchpoint를 설정한다.

<br>

```
$ gdb -q ./canary
pwndbg> catch syscall arch_prctl
Catchpoint 1 (syscall 'arch_prctl' [158])
pwndbg> run
```

<br>

catchpoint에 도달했을 때, `rdi`의 값이 `0x1002`인데 이 값은 `ARCH_SET_FS`의 상숫값이다.  
`rsi`의 값이 `0x7ffff7fdb4c0`이므로 이 프로세스는 TLS를 `0x7ffff7fb4c0`에 저장할 것이며 `fs`는 이걸 가리키게 된다.

<br>

카나리가 저장될 `fs+0x28(0x7ffff7fdb4c0+0x28)`의 값을 보면, 아직 값이 설정되지 않은 것을 볼 수 있다.

<br>


```
Catchpoint 1 (call to syscall arch_prctl), 0x00007ffff7dd6024 in init_tls () at rtld.c:740
740	rtld.c: No such file or directory.
 ► 0x7ffff7dd4024 <init_tls+276>    test   eax, eax
   0x7ffff7dd4026 <init_tls+278>    je     init_tls+321 <init_tls+321>
   0x7ffff7dd4028 <init_tls+280>    lea    rbx, qword ptr [rip + 0x22721]
pwndbg> info register $rdi
rdi            0x1002   4098          // ARCH_SET_FS = 0x1002
pwndbg> info register $rsi
rsi            0x7ffff7fdb4c0   140737354032320 
pwndbg> x/gx 0x7ffff7fdb4c0+0x28
0x7ffff7fdb4e8:	0x0000000000000000
```

<br><br>

### **카나리 값 설정**


<br>

TLS의 주소를 확인했으므로, gdb의 `watch` 명령어로 `TLS+0x28`에 값을 쓸 떄 프로세스를 중단시킨다. watch는 특정 주소에 저장된 값이 변경되면 프로세스를 중단시키는 명령어이다.

<br>

```
pwndbg> watch *(0x7ffff7fdb4c0+0x28)
Hardware watchpoint 4: *(0x7ffff7fdb4c0+0x28)
```

<br>

watchpoint를 설정 후 프로세스를 계속 진행시키면 `security_init` 함수에서 프로세스가 멈춘다.

<br>

```
pwndbg> continue
Continuing.
Hardware watchpoint 4: *(0x7ffff7fdb4c0+0x28)
Old value = 0
New value = -1942582016
security_init () at rtld.c:807
807	in rtld.c
```

<br>

여기서 `TLS+0x28(0x7ffff7fdb4c0+0x28)`의 값을 조회하면 `0x2f35207b8c368d00`이 카나리로 설정된 것을 확인할 수 있다.

<br>


```
pwndbg> x/gx 0x7ffff7fdb4c0+0x28
0x7ffff7fdb4e8:	0x2f35207b8c368d00
```

<br>

실제로 이 값이 `main` 함수에서 사용하는 카나리값인지 확인하기 위해 `main` 함수에 중단점을 설정하고 확인시켜 보고, `mov rax, QWORD PTR fs:0x28`을 실행시킨 후 `rax`값을 확인해보면 `security_init`에서 설정한 값과 같은 것을 확인할 수 있다.

<br>

```
Breakpoint 3, 0x00005555555546ae in main ()
pwndbg> x/10i $rip
 ► 0x5555555546ae <main+4>:	    sub    rsp,0x10
   0x5555555546b2 <main+8>:	    mov    rax,QWORD PTR fs:0x28
   0x5555555546bb <main+17>:	mov    QWORD PTR [rbp-0x8],rax
   0x5555555546bf <main+21>:	xor    eax,eax
   0x5555555546c1 <main+23>:	lea    rax,[rbp-0x10]
   0x5555555546c5 <main+27>:	mov    edx,0x20
   0x5555555546ca <main+32>:	mov    rsi,rax
   0x5555555546cd <main+35>:	mov    edi,0x0
   0x5555555546d2 <main+40>:	call   0x555555554580 <read@plt>
   0x5555555546d7 <main+45>:	mov    eax,0x0
pwndbg> ni
0x00005555555546b2 in main ()
pwndbg> ni
0x00005555555546bb in main ()
pwndbg> i r $rax
rax            0x2f35207b8c368d00	3401660808553729280
pwndbg> 
```

<br><br><br>

---

<br>

## **카나리 우회**

<br>

### **무차별 대입(Brute Force)**

<br>

`x64 아키텍처`에서는 8바이트의 카나리가 생성되고, `x86 아키텍처`에서는 4바이트의 카나리가 생성된다. 각각의 카나리엔 첫 바이트가 NULL 바이트이므로 각자 7바이트와 3바이트의 랜덤한 값이 포함된다.

<br>

즉, `Brute Force` 공격으로 카나리 값을 알아내려면 `x64` 아키텍처에서는 최대 256^7번, `x86`에서는 최대 256^3번의 연산이 필요하다. `x64`에서는 알아내는 것 자체가 현실적으로 불가능하며, `x86 `에서는 알아낼 수는 있지만, 실제 서버를 대상으로 저정도 횟수의 공격을 시도하는 것은 불가능하다.

<br><br>

### **TLS 접근**

<br>

카나리는 TLS에 전역변수로 저장되며 매 함수마다 이를 참조하여 사용하는데, TLS의 구조는 매 실행마다 바뀌지만 만약 실행 중에 TLS의 주소를 알 수 있고, 임의 주소에 대한 읽기 또는 쓰기가 가능하다면 TLS에 설정된 카나리 값을 읽거나 이를 조작할 수 있다.  

<br>

그 뒤, 공격을 수행할 때 알아낸 카나리 값이나 조작한 값으로 스택 카나리를 덮으면 카나리 검사를 우회할 수 있다.

<br><br>

### **스택 카나리 릭**

<br>

스택 카나리를 읽을 수 있는 취약점이 있다면 이를 이용하여 카나리 검사를 우회할 수 있다. 가장 현실적인 우회 방법이다.