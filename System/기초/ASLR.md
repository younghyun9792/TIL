# **ASLR(Address Space Layout Randomization)**

<br>

`ASLR`은 **바이너리가 실행될 때마다 스택, 힙, 공유 라이브러리 등을 임의의 주소에 할당하는 보호 기법**이다.

<br>

`ASLR`의 활성화 여부는 다음의 명령어로 확인할 수 있다.

<br>

```sh
cat /proc/sys/kernel/randomize_va_space
```

<br>

리눅스에서 해당 값은 0,1,2 세 개중 하나인데 각각 아래를 의미한다.

+ NO ASLR(0) : ASLR을 적용하지 않는다.
+ Conservative Randomization(1) : 스택, 힙, 라이브러리, vdso 등
+ Conservative Randomization + brk(2) : (1)의 영역 + `brk`로 할당한 영역

<br><br>

---

<br>

## **ASLR의 특징**

<br>

```
$ ./addr
buf_stack addr: 0x7ffcd3fcffc0
buf_heap addr: 0xb97260
libc_base addr: 0x7fd7504cd000
printf addr: 0x7fd750531f00
main addr: 0x400667
$ ./addr
buf_stack addr: 0x7ffe4c661f90
buf_heap addr: 0x176d260
libc_base addr: 0x7ffad9e1b000
printf addr: 0x7ffad9e7ff00
main addr: 0x400667
$ ./addr
buf_stack addr: 0x7ffcf2386d80
buf_heap addr: 0x840260
libc_base addr: 0x7fed2664b000
printf addr: 0x7fed266aff00
main addr: 0x400667
```

<br>

+ 스택과 힙, 라이브러리 함수와 코드 main함수, 라이브러리 매핑 함수 등의 주소를 출력해주는 프로그램를 시켜보면, 실행 시마다 `main` 말고는 계속하여 바뀌는 것을 볼 수 있다. 때문에 프로그램을 실행하기 전에 해당 영역들의 주소를 예측할 순 없다.

<br>

+ 프로그램을 반복하여 실행해도 `printf` 주소의 하위 12bit 값은 바뀌지 않는데, 리눅스는 `ASLR`이 적용됐을 때 파일을 `페이지(page)` 단위로 임의 주소에 매핑한다. 즉, 페이지의 크기인 12bit 이하로는 주소가 변경되지 않는다.

<br>

+ `libc_base`와 `printf`의 주소 차이는 항상 같다. `ASLR`이 적용되면 라이브러리는 임의 주소에 매핑되지만, 라이브러리 파일을 그대로 매핑하는 것이므로 **매핑된 주소와 라이브러리의 다른 심볼들까지의 거리(Offset)은 항상 같다.**

<br>

```
>>> hex(0x7fd7504cd000 - 0x7fd750531f00) # libc_base addr - printf addr
'-0x64f00'
>>> hex(0x7ffad9e1b000 - 0x7ffad9e7ff00)
'-0x64f00'
```