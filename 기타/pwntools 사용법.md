# **pwntools 사용법**

<br>

## **process & remote**

<br>

### `process` 함수는 익스플로잇을 **로컬 바이너리(내부 파일)을 대상**으로 할 때 사용하고, `remote` 함수는 **원격 서버를 대상**으로 할 때 사용한다.

<br>

```py
p = process('./test') # 로컬 바이너리(내부 파일) 'test'를 대상으로 익스플로잇
p = remote('example.com',31337) # 원격 서버 'example.com'의 31337번 에서 실행중인 프로세스를 대상으로 익스플로잇
```

<br><br>

## **send**

<br>

### `send`는 **데이터를 프로세스에 전송**하기 위해 사용한다.

<br>

```py
p = process('./test')

p.send('A') # ./test에 'A'를 입력
p.sendline('A') # ./test에 'A'에 추가로 '\n'(줄바꿈)을 입력
p.sendafter('hello','A') # ./test가 'hello'를 출력 시 'A'를 입력
p.sendlineafter('hello','A') # ./test가 'hello'를 출력하면 'A' + '\n'을 입력
```

<br><br>

## **recv**

<br>

### `recv`는 프로세스에서 데이터를 받기 위해 사용한다.

<br>

```py
p = process('/test')

data = p.recv(1024) # p가 출력하는 데이터를 최대 1024바이트까지 받고, data에 저장함
data = p.recvline() # p가 출력하는 데이터를 '\n'(줄바꿈)을 만날 때까지 받아서 data에 저장
data = p.recvn(5) # p가 출력하는 데이터를 5바이트 만큼 받아서 data에 저장
data = p.recvunitl('hello') # p가 출력하는 데이터가 'hello'를 출력할 때까지 받아서 data에 저장
data = p.recvall() # p가 출력하는 데이터를 프로세스가 종료될 때까지 받아서 data에 저장
```

<br>

> ## **recv, recvn?**
> ### recv(n)은 최대 n바이트를 받고, 그만큼 받지 못해도 에러를 일으키지 않는다.
> ### 하지만, recvn(n)은 정확히 n바이트의 데이터를 받지 못하면 계속 n바이트를 받을 때까지 기다린다.

<br><br>

## **packing & unpacking**

<br>

### 익스플로잇을 작성할 때 어떤 값을 리틀 엔디안의 바이트 배열로 변경하거나, 또는 리틀 엔디안의 바이트 배열을 정상적으로 돌려야 하는 경우가 많은데, 그 때 사용한다.

<br>

```py
s32 = 0x41424344
s64 = 0x4142434445464748

print(p32(s32)) # b'DCBA'
print(s64(s64)) # b'HGFEDCBA'

s32 = "ABCD"
s64 = "ABCDEFGH"

print(hex(u32(s32))) # 0x44434241
print(hex(u64(s64))) # 0x4847464544434241
```

<br><br>

## **interactive**

<br>

### **셸을 획득**했거나, 익스플로잇의 특정 상황에 **직접 입력**을 주면서 출력을 확인하고 싶을 때 사용한다.

<br>

```py
p = process('./test')
p.interactive()
# 이후 사용자가 직접 입력
```

<br>

## **ELF**

<br>

### `ELF` 헤더에는 익스플로잇에 사용될 수 있는 각종 정보가 담겨 있는데, 그 값들을 참조하고 싶을 떄 사용한다.
<br>

```py
e = ELF('/test')
puts.plt = e.plt['puts'] # ./test에서 puts()의 PLT 주소를 찾아서 puts_plt에 저장
read_got = e.got['read'] # ./test에서 read()의 GOT 주소를 찾아서 read_got에 저장
```

<br><br>

## **context.log**

<br>

### 익스플로잇에 버그가 발생하면 익스플로잇도 디버깅해야 하는데, 그 디버깅 과정의 편의를 위한 로깅 기능이 pwntools에 있다. 로그 레벨을 context.log_level 변수로 조절할 수 있다.

<br>

```py
context.log_level = 'error' ## 에러만 출력
context.log_level = 'debug' # 대상 프로세스와 익스플로잇 간에 오가는 모든 데이터를 화면에 출력
context.log_level = 'info' # 비교정 중요한 정보들만 출력
```

<br><br>

## **context.arch**

<br>

### pwntools에서 셸코드를 생성하거나 코드를 어셈블, 디스 어셈블 하는 등 몇몇 기능은 공격 대상의 아키텍처에 영향을 받는데, 이걸 위해 아키텍처 정보를 프로그래머가 지정할 수 있다. 이 값에 따라 몇몇 함수의 동작이 달라진다.

<br>

```py
context.arch = "amd64" # x86-64 아키텍처
context.arch = "i386" # x86 아키텍처
context.arch = "arm" # arm 아키텍처
```

<br><br>

## **shellcraft**
<br>

### `pwnable`을 할 때 `shellcode`를 자주 사용하는데, pwntools에선 공격에 필요한 셸 코드들을 쉽게 꺼내 쓸 수 있게 해준다.
### 매우 편리한 기능이지만, 정적으로 생성된 셸 코드는 셸 코드가 실행될 때의 메모리 상태를 반영하지 못하고, 프로그램에 따라 입력할 수 있는 셸 코드의 길이나 구성 가능한 문자의 종류에 제한이 있을 때 반영하기 어렵다.
### 즉, 제약 조건이 존재하는 상황에선 직접 셸 코드를 작성하는 것이 좋다.

<br>

```py
context.arch = 'amd64' # 대상 아키텍처 = x86-64
code = shellcraft.sh() # 셸을 실행하여 code에 저장
print(code) # 셸코드 출력
```

<br><br>

## **asm**

<br>

### pwntools에서는 어셈블 기능도 제공하는데, 이 기능 또한 대상 아키텍처가 중요하므로 미리 지정해야 한다.

<br>

```py
context.arch = 'amd64' # 대상 아키텍처 = x86-64
code = shellcratf.sh() # 셸을 생성해서 code에 저장
code = asm(code) # 셸 코드를 기계어로 어셈블
print(code) # 기계어로 바뀐 셸코드 출력
```