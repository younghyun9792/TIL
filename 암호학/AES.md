# **AES**

<br>

* ### AES(Advanced Encryption Standard)는 연산 능력의 향상으로 DES가 더 이상 필요하지 않게 되자, 2001년에 새롭게 표준으로 선정된 블록 암호 알고리즘이다.

* ### 내부적인 논의만으로 표준으로 선정된 DES와 달리, AES는 전 세계에서 암호 알고리즘을 공모받고, 전문가들의 심사를 거쳐 그 중에서 가장 뛰어난 알고리즘이 선정되었다.

<br>

* ### 당시 공모에 제안된 21개의 암호 알고리즘들 중 보안성, 효율성, 하드웨어 이식의 적합성, 유연성 등을 고려하여 심사한 결과, Vincent Rijmen, Joan Deamen이 제안한 Rijndeal 구조가 채택되었다.

* ### AES는 이런 세계적인 논의를 거쳐 결정된 표준이었으므로, 미국 정보당국이 백도어를 설치했을 것이란 의심을 피해갈 수 있었다.

<br>

* ### 표준으로 선정된 후, AES는 현재까지도 기밀성을 위협하는 치명적인 취약점이 발견되지 않았다.

* ### 또한 CPU 제조사들이 AES 연산을 위해 명령어를 따로 정의해 주어 암호화, 복호화의 성능도 뛰어난데, 이런 이유로 현대에는 대칭키 암호 알고리즘을 사용할 떄 일반적으로 AES가 사용된다.

<br><br>

- - -

## **SPN**

<br>

* ### AES는 SPN(Substitution Permutation Network)이라는 암호 구조를 사용하는데, SPN은 곱암호의 일종으로 S-Box를 사용하는 치환(Substitution)과 P-Box를 사용하는 순열(Permutation)을 여러 라운드에 걸쳐 반복한다.

* ### 페이스텔 구조와 달리 라운드마다 입력 전체에 라운드 함수를 적용하므로, 같은 수의 라운드를 사용할 떄 SPN이 페이스텔 구조에 비해 두 배의 암호학적 안전성을 갖는다고 이야기한다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/22fa0a1c1b7de0cb7a5df261816bedec47d5f87bfea4a798381d224875493bbe.png)

<br><br>

## **AES 구조**

<br>

* ### AES는 라운드마다 128비트 크기의 블록을 암호화하는 블록 암호인데, 키의 길이는 128,192,256비트 중 하나를 선택할 수 있고, 라운드 수는 키의 길이에 따라 10, 12, 14로 설정된다. 128비트면 AES_128, 192비트면 AES-192 등으로 부른다.
  
* ### AES는 암호화를 할 때 가장 먼저 각 블록을 4행 4열의 상태 배열(State)를 재구성하는데, State의 각 칸에는 8Bit(1Byte)가 저장된다.

* ### 입력 1F3CF203B211C5AA6EB27A4E4D98130은 다음과 같은 State로 재구성된다.

<br>

```
|   1F  3C  F2  03  |
|   B2  11  C5  AA  |
|   6E  B2  7A  45  |
|   E4  D9  81  30  |
```

<br>

* ### 이후에는 재구성된 입력에 대해 AddRounKey 함수를 적용하고, 마지막 라운드 전까지 매 라운드마다 SubBytes, ShiftRows, Mixcolumns, AddRounKey 함수를 반복하여 적용하는데, 마지막 라운드에서는 MixColumns를 제외한 나머지 함수들만 적용한다.

* ### AES의 라운드 함수들은 역함수가 존재하므로, 역함수를 이용하여 AES 복호화가 이루어진다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/8ecdc95155a04df21a4299147db394f3aa52d596fbe73987c40481bb84c96825.png)

<br><br>

- - -
<bv>

## **AES 라운드 함수**

<br>

## SubBytes

<br>

* ### SubBytes는 State의 각 바이트를 S-Box를 참조하여 치환하는 함순데, 바이트의 상의 4비트가 행, 하위 4비트가 열을 결정한다. 예를 들어 어떤 바이트가 2A라면 해당 바이트는 S-Box의 2행 A열을 참조하여 E5로 치환된다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/98dbd818518df8d63d456242b42e516b94d5f17d03975c62b9ab90b71710b2bd.png)

<br>

* ### S-BoX

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/5010c36777dfdcab396c3087f4507dfc27be42879d68415ac9557118a185fa62.png)

<br><br>

## ShiftRows

<br>

* ### ShiftRows는 State의 각 행을 구성하는 바이트들을 쉬프트하는 함순데, 이 함수는 4가지 함수 중에서 유일하게 순열의 역할을 수행한다.

* ### 아래와 같이 2행은 왼쪽으로 1칸, 3행은 왼쪽으로 2칸, 4행은 왼쪽으로 3칸을 민다.

* ### 복호화할 떄에는 반대로 2,3,4행을 오른쪽으로 1,2,3칸 민다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/db1161779db2d5101d1c00a4e16571d2a63d7dcb6c520a18ed98807fc643e75f.png)

<br><br>

## MixColumns

<br>

* ### MixColumns는 열 단위로 치환을 수행하는 함순데, 이 치환은 갈루아 필드 내에서의 행렬 연산으로 구해진다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/8713f6ede25c1970d003de7df74e2cff94b0a4f9f45fce20cfa5ee97209f9a56.png)

<br><br>

## AddRoundKey

<br>

* ### 이 함수는 키 생성 함수(Key Schedule)로 생성된 라운드 키의 state를 각 바이트별로 XOR하는데, 복호화할 때는 XOR의 성질을 이용하여 동일한 키를 state에 XOR한다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/22e2e4a520146125bbc5f85149d5454327b226984271b694c18bb2a93bec935f.png)

<br><br>

## KeySchedule
<br>

* ### 키 생성 함수는 입력된 키로부터 각 라운드에 쓰일 라운드 키를 생성한다.

<br>



<br><br>

## RotWord

<br>

* ### 열을 위로 한 번 회전시킨다.

<br><br>

## SubWord

<br>

* ### SubBytes에서 사용한 것과 동일한 S-Box를 사용하고 각 바이트를 치환한다.

<br><br>

## Rcon

<br>