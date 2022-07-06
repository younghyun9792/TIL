# **Calling Convention**

<br><br>

## **Calling Convention(함수 호출 규약)**

<br>

`Calling Convention`은 **함수의 호출 및 반환**에 대한 약속이다.  
한 함수에서 다른 함수를 호출할 떄, 프로그램의 실행 흐름은 다른 함수로 이동하고 호출한 함수가 반환하면 다시 원래의 함수로 돌아와서 기존의 실행 흐름을 이어 나가는데, 그러므로 함수를 호출할 때는 반환된 이후를 위해 **호출자(Caller)의 상태(Stack Frame)과 반환 주소(Return Address)를 저장해야 한다.**  
호출자는 **피호출자(Callee) 가 요구하는 인자를 전달**해줘야 하며 피호출자의 실행이 종료될 때는 반환 값을 전달 받아야 한다.

<br>

함수 호출 규약을 적용하는 것은 보통 컴파일러의 몫으로, 프로그래머가 고수준 언어로 코드를 작성 시 컴파일러가 `Calling Convention`에 맞게 코드를 컴파일한다.  
프로그래머가 코드에 명시하지 않으면, 컴파일러는 지원하는 호출 규약 중 **CPU의 아키텍처에 적합한 것을 선택**한다. 이 때문에 대개의 프로그래머는 함수 호출 규약을 몰라도 코드를 작성하는데 문제가 없다.

<br>

하지만, 컴파일러의 도움 없이 **어셈블리 코드를 작성하려 하거나 어셈블리로 작성된 코드를 읽고자 한다면 함수 호출 규약을 알아야 한다.**
시스템 해킹에서는 어셈블리 코드 작성과, 작성된 코드를 읽는 것 모두 필수적이므로 시스템 해킹을 공부하고자 하려면 알야두어야 한다.

<br><br>

## **Calling Convention의 종류**

<br>

위에서 말했다 시피 컴파일러는 지원하는 호출 규약 중 CPU 아키텍처에 적합한 것을 선택한다.  
예를 들면, **x86(32bit) 아키텍처**는 레지스터를 통해 피호출자(Callee)의 인자를 전달하기에는 레지스터의 수가 적으므로 스택으로 인자를 전달하는 규약을 사용하고, [x86-64 아키텍처](x86-64%20아키텍처.md)에서는 레지스터가 많으므로 적은 수의 인자는 레지스터만 사용하여 인자를 전달하고 인자가 많을 때에만 스택을 사용한다.

<br>

CPU의 아키텍처가 같아도 컴파일러가 다르면 적용하는 호출 규약이 다를 수 있는데, 예를 들면 C를 컴파일할 때 Window에선 `MSVC`를, Linux에선 `gcc`를 많이 사용한다.  
이 둘은 같은 아키텍처에 대해서도 다른 호출 규약을 적용한다.  
[x86-64 아키텍처](x86-64%20아키텍처.md)에서 `MSVC`는 `MS x64` 호출 규약을 사용하지만, `gcc`는 `SYSTEM V` 호출 규약을 적용한다.



<br><br>

## **cdecl**

<br>

`cdecl`은 `Linux gcc`에서 `x86 Binary`를  컴파일할 때 사용하는 호출 규약이다.  
앞에서 말했듯이 **x86 아키텍처**는 레지스터의 수가 적으므로, **`Stack`** 을 통해 인자를 전달한다.  
<br>

또한, 인자를 전달하기 위해 **사용한 스택을 호출자(Caller)가 정리**하는 특징이 있다.  

<br>

```c
// Name: cdecl.c
// Compile: gcc -fno-asynchronous-unwind-tables -nostdlib -masm=intel \
//          -fomit-frame-pointer -S cdecl.c -w -m32 -fno-pic -O0
void __attribute__((cdecl)) callee(int a1, int a2){ // cdecl로 호출
}
void caller(){
   callee(1, 2);
}
```

<br>

```
; Name: cdecl.s
	.file	"cdecl.c"
	.intel_syntax noprefix
	.text
	.globl	callee
	.type	callee, @function
callee:
	nop
	ret ; 스택을 정리하지 않고 리턴합니다.
	.size	callee, .-callee
	.globl	caller
	.type	caller, @function
caller:
	push	2 ; 2를 스택에 저장하여 callee의 인자로 전달합니다.
	push	1 ; 1를 스택에 저장하여 callee의 인자로 전달합니다.
	call	callee
	add	esp, 8 ; 스택을 정리합니다. (push를 2번하였기 때문에 8byte만큼 esp가 증가되어 있습니다.)
	nop
	ret
	.size	caller, .-caller
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
```

<br>

> ### **컴파일이란?**
> 정확한 의미로는 어떤 언어로 작성된 **소스 코드(Source Code)를 다른 언어의 목적 코드(Object Code)로 번역하는 것**이다.  
> 소스 코드를 어셈블리어로, 또는 소스 코드를 기계어로 번역하는 것 모두 컴파일의 범주에 포함된다.  
> 이 때문에 C언어를 실행 파일로 만드는 과정(전처리-컴파일-어셈블-링크)를 합채서 '컴파일' 이라고 부를 수 있다.

<br><br>

## **SYSTEM V(SYSV)**

<br>

`SYSV`는 [x86-64](x86-64%20아키텍처.md) 바이너리를 컴파일할 때 사용하는 호출규약이다.  

<br>

리눅스는 `SYSV ABI(SYSTEM V Application Binary Interface)`를 기반으로 만들어졌다.  
`SYSV ABI`는 ELF 포맷, 링킹 방법, 함수 호출 규약 등의 내용을 담고 있다.  
`file` 명령어를 이용하여 바이너리의 정보를 살펴보면 아래와 같이 SYSV 문자열이 포함된 것을 확인할 수 있다.

<br>

```sh
$ file /bin/ls
/bin/ls: ELF 64-bit LSB shared object, x86-64, ersion 1 (SYSV) 
...
```

<br>

`SYSV`에서 정의한 함수 호출 규약은 다음의 특징을 갖는다.

<br>

1. 6개의 인자를 `RDI`, `RSI`, `RDX`, `RCX`, `R8`, `R9` 에 순서대로 저장하여 전달하고, 더 많은 인자를 사용해야 할 때엔 스택을 추가로 이용한다.
2. `Caller`에서 인자 전달에 사용된 스택을 정리한다.
3. 함수의 반환 값은 `RAX`로 전달한다.


<br>
<br>

## **그 외....**

<br>

### **x86 Calling Convention**  


|함수 호출 규약|사용 컴파일러|인자 전달 방식|스택 정리|적용|
|:---:|:---:|:---:|:---:|:---:|
|**stscall**|MSVC|Stack|Callee|WINAPI|
|**cdecl**|gcc, MSVC|Stack|Caller|일반 함수|
|**fastcall**|MSVC|ECX, EDX|Callee|최적화 된 함수|
|**thiscall**|MSVC|ECX(인스턴스), Stack(인자)|Callee|클래스의 함수|

<br>

### **x86-64 Calling Convention**  


|함수 호출 규약|사용 컴파일러|인자 전달 방식|스택 정리|적용|
|:---:|:---:|:---:|:---:|:---:|
|**MS ABI**|MSVC|RCX, RDX, R8, R9|Caller|일반 함수, Windows Syscall|
|**System ABI**|gcc|RDI, RSI, RDX, RCX, R8, R9, XMM 0-7|Caller|일반 함수|