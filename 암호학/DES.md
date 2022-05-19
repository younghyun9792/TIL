# **DES**

<br>

* ### DES(Data Encryption Standard)는 미국의 국가 안보국(NSA)에서 IBM의 루시퍼 알고리즘을 개량하여 만든 **대칭키 암호**이다.
* ### DES는 루시퍼에서 128비트 키를 사용했던 것과 달리 키 길이를 56비트로 줄였고, 내부에서 사용하는 알고리즘도 일부 변경하였다.

* ### 국립표준기술연구소는 DES를 1976년부터 2002년까지 표준 블록 암호로 인정하였지만, 현대에는 DES에 대한 공격 기법이 많이 연구되어 더 이상 DES를 블록 암호의 표준으로 사용하지 않는다.

* ### DES는 8바이트(64비트)를 한 블록으로 하는 블록 암호이며,전체 구조는 오른쪽 그림과 같이 초기 순열(Initial Permutation,IP), 최종 순열(FP), 페이스텔(Feistel)구조의 16라운드, 그리고 각 라운드에 사용되는 48비트의 키를 생성하는 키 생성 함수(Key Generation)로 구성되어 있다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/163eca1699cd1f5f39e5ea8161d2e629cfbbb2a9043dbacb511688f28ea4bb61.png)

<br>


## **순열과 치환, 그리고 곱 암호**


- - -

<br>

* ### DES는 혼돈 성질을 만족하기 위해 치환(Substitution)을, 확산 성질을 만족하기 위해 순열(Permuatation)을 사용한다.

* ### 치환과 순열은 매우 단순한 연산이므로 평문에 이들을 한 번적용한다고 해서 암호학적 효과를 기대할 수 없으나, 이들을 여러 번 교차해서 반복 적용하면 혼돈과 확산 모두 만족한다.

* ### 이런 특성을 이용해 치환이나 순열같은 단순한 연산들로 한 라운드를 구성하고, 각 라운드를 여러 번 반복하여 암호학적 안전성을 확보하는 암호를 곱 암호(Product Cipher)라고 한다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/4fad2bddeaf506929528329a0ff5075275d45b52c70b318648ae63a9ad47aa98.png)

<br>


## **페이스텔 구조**


- - -

<br>

* ### DES에서 라운드 함수를 적용하는 전체 과정은 아래와 같은 페이스텔 구조를 이룬다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/3e193242b6df194fa9f452d6a8a87fb2608b33d5664e3cd4f6718c2336e60509.png)

<br>

* ### 페이스텔 구조를 따르는 DES는 먼저 입력으로 들어온 블록을 동일한 길이의 왼쪽 블록 L과 오른쪽 블록 R로 나눈다.

* ### 그리고, 각 라운드마다 오른쪽 블록은 다음 라운드의 왼쪽 블록으로 입력되고, 왼쪽 블록은 오른쪽 블록에 라운드 함수 F를 적용한 결과와 xor되어 다음라운드의 오른쪽 블록으로 입력된다.

* ### 이를 정형화해서 나타내면 다음과 같은데, 여기서 P는 입력으로 들어온 평문, K는 각 라운드에서 생성된 키를 말한다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/e90644f3-a4f6-4d96-bb7a-e8e19a6f12ab/image.png)

<br>

* ### 페이스텔 암호의 특징으로는, 블록 암호는 암호문을 복호화 할 수 있어야 하므로 일반적으로 암호화를 구성하는 각 함수들에 대한 역함수가 존재한다.

* ### 그러나, 페이스텔 구조를 사용하면 F가 복호화 과정에서 상쇄되므로 역함수가 존재하지 않아도 되고, 또한 암호화와 복호화의 구조가 동일하므로, 암호화에 사용한 라운드 키를 역순으로 입력하면 복호화가 이루어진다.

- - -

<br>

## **DES의 과정**

<br>

## 1단계(초기 순열), 3단계(최종 순열)

<br>

* ### DES는 시작할 때 초기 순열을(IP)를, 마지막에는 최종 순열(FP)를 수행하는데, 초기 순열과 최종 순열은 정해진 테이블을 이용하여 64비트 입력을 비트 단위로 전치한다. 

* ### 테이블의 n번째 값이 m일 때 출력의 n번째 비트는 입력의 m번째 비트가 된다.

* ### 초기 순열과 최종 순열은 각각 초기 순열 테이블(IPT)과 최종 순열 테이블(FPT)를 이용하는데, 서로 역관계에 있다. 임의의 64비트에 초기 순열을 적용하고, 최종 순열을 적용하면 입력 값이 그대로 출력된다.

* ### 아래 코드는 이 과정을 파이썬 코드로 구현한 것이다.

<br>

```py
# Name: des.py
# Initial/Final Permutation Table
IPT = [58, 50, 42, 34, 26, 18, 10, 2,
       60, 52, 44, 36, 28, 20, 12, 4,
       62, 54, 46, 38, 30, 22, 14, 6,
       64, 56, 48, 40, 32, 24, 16, 8,
       57, 49, 41, 33, 25, 17, 9, 1,
       59, 51, 43, 35, 27, 19, 11, 3,
       61, 53, 45, 37, 29, 21, 13, 5,
       63, 55, 47, 39, 31, 23, 15, 7]
FPT = [40, 8, 48, 16, 56, 24, 64, 32,
       39, 7, 47, 15, 55, 23, 63, 31,
       38, 6, 46, 14, 54, 22, 62, 30,
       37, 5, 45, 13, 53, 21, 61, 29,
       36, 4, 44, 12, 52, 20, 60, 28,
       35, 3, 43, 11, 51, 19, 59, 27,
       34, 2, 42, 10, 50, 18, 58, 26,
       33, 1, 41, 9, 49, 17, 57, 25]
def plain2bitstring(plain: str):
    return "".join(format(ord(c), "0>8b") for c in plain)
def plain2bitarray(plain: str):
    bitstring = plain2bitstring(plain)
    encoded = bytearray([int(b) for b in bitstring])
    return encoded
def bitarray2plain(bitarray: bytearray):
    bitstring = bitarray2bitstring(bitarray)
    encoded = "".join([chr(int(bitstring[i*8:i*8+8], 2))
                       for i in range(len(bitstring)//8)])
    return encoded
def bitarray2bitstring(bitarray: bytearray):
    return "".join([str(b) for b in bitarray])
def permutation(block: bytearray, table: list[int], outlen: int):
    permutated = bytearray(outlen)
    for n in range(len(table)):
        m = table[n]-1
        permutated[n] = block[m]
    return permutated
plain = "DEScrypt"
key = "DREAMCRY"
bitarray = plain2bitarray(plain)
print(f"bitstring of '{plain}': {bitarray2bitstring(bitarray)}")
# Initial permutation
initial_permutated = permutation(bitarray, IPT, 64)
print(
    f"bitstring of initial_permutated: {bitarray2bitstring(initial_permutated)}")
# Final permutation
final_permutated = permutation(initial_permutated, FPT, 64)
print(f"bitstring of final_permutated: {bitarray2bitstring(final_permutated)}")
# plain == FP(IP(plain)) => FP = IP^{-1}
print(f"plaintext of final_permutated: {bitarray2plain(final_permutated)}")

```

<br><br>

## 2 라운드 함수

<br>

* ### 라운드 함수 F에는 오른쪽 블록만 입력되므로, 입력의 길이는 32비트이다. 라운드 함수는 확장 순열(Expansion P-Box), 라운드 키 결합(XOR), 치환 테이블(S-BOX) 그리고 고정 순열 (Straight P-BOX)로 이루어져 있다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/e9008280436169918540e3a1e99aeeebce7f3415152c97ad7d6e1d564e68e1b4.png)

<br>

* ### 확장 순열(Expansion P-BOX)은 입력을 비트 단위로 전치하는 동시에 전체 길이를 48비트로 확장한다. 이 과정에서 32비트의 입력값을 4비트씩 8개의 부분으로 나누고, 테이블을 참조하여 각각을 6비트로 확장한다.

* ### 이 과정은 테이블만 다를 뿐, 초기 순열, 최종 순열과 같은 방식으로 이뤄지며 라운드 키 결합은 확장 순열로 나온 출력을 라운드 키 K와 xor 하는 것이다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/a06a2b485e112d257d18d633539815d3204b482f576fb21ac8826342f6cd5790.png)

<br>


```py
#!/usr/bin/env python3
# Name: DES
# Expansion P-Box Table
EPT = [32, 1, 2, 3, 4, 5,
       4, 5, 6, 7, 8, 9,
       8, 9, 10, 11, 12, 13,
       12, 13, 14, 15, 16, 17,
       16, 17, 18, 19, 20, 21,
       20, 21, 22, 23, 24, 25,
       24, 25, 26, 27, 28, 29,
       28, 29, 30, 31, 32, 1]
#Initial permutation
...
# Feistel
left_half = initial_permutated[:32]
right_half = initial_permutated[32:]
# Iterates 16 rounds
for round in range(16):
    # Expansion
    expansioned = permutation(right_half, EPT, 48)
    # XOR with round key
    for bit_idx in range(48):
        expansioned[bit_idx] ^= round_keys[round][bit_idx]
...
# Final permutation
...
```

<br>

* ### S-BOX(Substitution-BOX)는 라운드 키 결합에서 출력된 48비트 결과 값을 32비트로 축소한다.

* ### S-BOX는 4개의 행과 16개의 열로 이루어진 표를 사용하는데, 표의 각 값은 4비트로 표현되는 수이다.

* ### 먼저, 입력을 여섯 비트씩 8개의 부분으로 나누고, 여섯 비트 중 첫 번째와 마지막 비트로 행을 결정하고 나머지 네 개의 비트로 열을 결정한다. 그 뒤, S-BOX의 표에서 행과 열을 참조하여 값을 변환한다. DES에서는 여섯 비트로 자른 부분마다 다른 S-BOX를 사용한다.

* ### S-BOX로 길이를 축소하고 나면, 고정 순열(Straight P-BOX)로 다시 비트 단위 전치가 이뤄진다.

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/380f0291c3b2e51ddb5b1bdfed1e3326cd58d23fe160fc6d4d61b74246c050ea.png)

<br>

```py
# Name: des.py
# S-Boxes
S = [
    # S1
    [
        [14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7],
        [0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8],
        [4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0],
        [15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13]
    ],
     ...
    # S8
    [
        [13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7],
        [1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2],
        [7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8],
        [2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11],
    ]
]
# Straight P-Box Table
SPT = [16, 7, 20, 21, 29, 12, 28, 17,
       1, 15, 23, 26, 5, 18, 31, 10,
       2, 8, 24, 14, 32, 27, 3, 9,
       19, 13, 30, 6, 22, 11, 4, 25]
def substitution(block, table):
    row = (block[0] << 1) + block[5]
    column = (block[1] << 3) + (block[2] << 2) + (block[3] << 1) + block[4]
    val = table[row][column]
    binary = bin(val)[2:].zfill(4)
    return bytearray([int(b) for b in binary])
#Initial Permutation
...
# Feistel
...
# Iterate 16 rounds
for i in range(16):
   # Expansion
   expansioned = permutation(right_half, EPT, 48)
   # XOR with round key
   for j in range(48):
        expansioned[j] ^= round_keys[i][j]
   # Substitution
   substituted = bytearray(32)
   for block_idx in range(8):
       substituted[4*block_idx:4*block_idx+4] = substitution(expansioned[6*block_idx:6*block_idx+6], S[block_idx])
    # Straight
    straighted = permutation(substituted, SPT, 32)
...
# Final Permutation
...
```

<br><Br>

* ## 키 생성 함수

<br>

* ### 키 생성 함수(Key Scheduling)는 64비트의 입력을 받아 각 라운드에 필요한 48비트 라운드 키를 생성하는 함수인데, 이 함수는 패리티 비트 제거(Parity Bit Drop), 쉬프트(Shift), 압축 순열(Compression P-BOX)로 구성되어 있다.

* ### 패리티 비트 제거는 입력에서 패리티 비트를 제거하고, 남은 56비트에 순열을 적용하는 과정으로, 비밀키에서 각 바이트의 가장 오른쪽 비트는 자신이 속한 바이트의 나머지 7비트에 대한 홀수 패리티 비트 이다.

* ### 홀수 패리티 비트란 한 바이트를 이진수로 표현했을 때 1의 개수가 홀수가 되도록 덧붙인 비트를 말하는데, 예를 들어 1010101에는 1이 4개 있다. 홀수 패리티 비트를 적용하면 끝에 비트 1을 덧붙여서 10101011을 전송해야 한다.

* ### 패리티 비트는 통신 중에 비트 반전이 일어나지 않았음을 보증하는 역할을 하며, 홀수 패리티 비트를 사용하여 통신할 때 수신한 바이트 중 1의 갯수가 짝수인 바이트가 있다면 그 바이트에서 임의의 비트가 반전이 일어났음을 알 수 있고, 수신자는 손상되지 않은 데이터를 얻기 위해 재전송을 요구할 수 있다.

<br><br>

* ### 쉬프트는 입력을 왼쪽 28비트와 오른쪽 28비트로 나누어 각각을 1비트나 2비트만큼 오니쪽으로 순환 쉬프트(Cyclic Shift)하는 과정으로, 1,2,9,16라운드에서는 1비트, 나머지 라운드에서는 2비트만큼 쉬프트한다.

* ### 10101111을 왼쪽으로 1비트 순환 쉬프트하면 왼쪽 끝의 비트가 오른쪽 끝으로 이동하여 01011111이 되고, 마찬가지로 2비트를 왼쪽으로 순환 쉬프트하면 왼쪽 끝의 '10'이 오른쪽으로 이동하여 10111110이 된다.

<br><br>

* ### 압출 순열은 56비트의 입력을 48비트로 압축하는 과정으로 수행 방법은 앞서 설명한 순열들과 같다.

<br><br>

```py
#!/usr/bin/env python3
# Name: des.py
# Parity Bit Drop Table
PBDT = [57, 49, 41, 33, 25, 17, 9,
        1, 58, 50, 42, 34, 26, 18,
        10, 2, 59, 51, 43, 35, 27,
        19, 11, 3, 60, 52, 44, 36,
        63, 55, 47, 39, 31, 23, 15,
        7, 62, 54, 46, 38, 30, 22,
        14, 6, 61, 53, 45, 37, 29,
        21, 13, 5, 28, 20, 12, 4]
# Compression P-Box Table
CPBT = [14, 17, 11, 24, 1, 5, 3, 28,
        15, 6, 21, 10, 23, 19, 12, 4,
        26, 8, 16, 7, 27, 20, 13, 2,
        41, 52, 31, 37, 47, 55, 30, 40,
        51, 45, 33, 48, 44, 49, 39, 56,
        34, 53, 46, 42, 50, 36, 29, 32]
...
def key_scheduling(key: bytearray):
    shift_1 = [0, 1, 8, 15]
    round_keys = []
    # Drop parity bit
    parity_erased = permutation(key, PBDT, 56)
    left = parity_erased[:28]
    right = parity_erased[28:]
    # Shift
    for i in range(16):
        if i in shift_1:
            left = left[1:] + left[0:1]
            right = right[1:] + right[0:1]
        else:
            left = left[2:] + left[:2]
            right = right[2:] + right[:2]
        # Compression
        round_keys.append(permutation(left+right, CPBT, 48))
    return round_keys
...
key = "DreamCry"
key_bitarray = plain_to_bits(key)
# Key scheduling
round_keys = key_scheduling(key_bitarray)
```

<br><br>

- - -

## **DES의 응용**

<br>

* ### 연산 능력이 증대되고, 관련된 공격 기법이 연구됨으로 인해 DES는 더 이상 안전한 암호가 아니다.

* ### 다중 DES는 서로 다른 키를 사용하는 DES 모듈을 여러 개 이어붙여서 DES의 약점을 보완한 암호로 DES를 두 겹으로 사용하는 이중 DES는 112비트, 삼중 DES는 168비트의 키를 사용한다.

* ### 이중 DES나 삼중 DES는 늘어난 키 길이 만큼 단일 DES보다 안전할 것 같지만, 중간 일치 공격(Meet-in-the-Middle Attack)으로 인해 안전성을 획기적으로 높이지는 못한다.