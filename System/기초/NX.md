# **NX(No-eXecute)**

<br>

`NX`는 **실행에 사용되는 메모리 영역과 쓰기에 사용되는 메모리 영역을 분리하는 보호기법**이다.

<br>

어떤 메모리 영역에 대해 쓰기 권한과 실행 권한이 함께 있으면 시스템이 취약해쥐기 쉽다. 예를 들어서, 코드 영역에 쓰기 권한이 있으면 공격자는 코드를 수정하여 원하는 코드가 실행되게 할 수 있고, 스택이나 데이터 영역에 실행 권한이 있으면 Return to shellcode와 같은 공격을 시도할 수 있다.

<br>

`NX`가 적용된 바이너리는 실행될 때 각 메모리 영역에 필요한 권한만을 부여받으며, `gdb`의 `vmmap`을 이용해 `NX` 적용 전후의 메모리를 확인하면 `NX` 적용 전엔 스택, 힙, 데이터 영역에 실행 권한이 존재하지만, `NX` 적용 후엔 코드 영역 외엔 실행 권한이 없는 것을 확인할 수 있다.

<br>

`checksec`을 이용해 `NX`의 적용 여부를 확인할 수 있다.

<br>

```
$ checksec ./nx
[*] '/home/dreamhack/nx'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      No PIE (0x400000)
```

<br><br>

> ### NX의 다양한 명칭
> NX를 인텔에서는 `XD(eXecute Disable)`, AMD에서는 `NX`, 윈도우는 `DEP(Data Execution Prevention)`, ARM에서는 `XN(eXecute Never)`라고 부른다. 명칭만 다르고, 모두 비슷한 보호 기법이다.

<br>

컴파일할 때 `-zexecstack` 옵션을 붙일 시 `NX`를 제거할 수 있다. 