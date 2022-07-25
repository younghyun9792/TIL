# **pwnable 기초설정**

<br>

리눅스 환경에서 진행(Ubuntu 20.04)

<br>


## **초기 설정**

<br>

모든 작업은 `su` 명령으로 `root` 권한으로 진행함! 불가능할 시 `sudo` 명령어 앞에 붙여주기

```sh
apt-get update
apt-get upgrade -y
```

<br><br>

## **pwntools 설치**

<br>

```sh
apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools
```

<br>

해당 작업 후 아래와 같이 오류가 나지 않아야 함

```py
❯ python
Python 3.8.10 (default, Jun 22 2022, 20:18:18)
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from pwn import *
>>>
```

<br><br>

## **3. pwndbg 설치**

<br>

```sh
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
```

<br>

모두 설치 후 gdb를 사용하면 아래와 같이 어셈블리어를 실행했을 때의 레지스터, 스택 등의 구조를 한 눈에 보여준다.

<br>

![이미지](https://cdn.discordapp.com/attachments/847295675396915290/1000384384492376194/unknown.png)
