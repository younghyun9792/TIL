# **인덱스(Index)**

<br>

* ### 인덱스는 데이터를 빠르게 검색할 수 있는 방법을 제공한다.

<br>

* ### 인덱스는 인덱스 키(예 : EMPNO)로 정렬(SORT)되어 있기 때문에 원하는 데이터를 빠르게 조회한다.

<br>

* ### 인덱스는 오름차순(ASCENDING) 및 내림차순(DESCENDING) 탐색이 가능하다.

<br>

* ### 하나의 테이블에 여러 개의 인덱스를 생성할 수 있고, 하나의 인덱스는 여러 개의 컬럼으로 구성될 수 있다.

<br>

* ### 테이블을 생성할 때 기본 키(Priamry Key)는 자동으로 인덱스가 만들어지고 인덱스의 이름은 SYSXXXX이다.

![이미지](https://velog.velcdn.com/images/as979200/post/fa929657-6110-48e3-8953-83bda5c7c184/image.png)

<br>

* ### 인덱스의 구조는 Root Block, Branch Block Leaf Block으로 구성되고 Root Block은 인덱스 트리에서 가장 상위에 있는 노드를 의미하며 Branch Block은 다음 단계의 주소를 가지고 있는 포인터(Pointer)로 되어 있다.

<br>

* ### Leaf Block은 인덱스 키와 ROWID로 구성되고 인덱스 키는 정렬되어서 저장되어 있다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/856381fb-d74b-43e6-a440-ec358da98c5f/image.png)

<br>

* ### 위의 예는 인덱스를 스캔하고 테이블을 참조하는 것을 설명하고 있다.

<br>

* ### Leaf Block은 Double linked list 형태로 되어 있어서 양방향 탐색이 가능하고, Leaf Block에서 인덱스 키를 읽으면 ROWID를 사용해서 EMP테이블의 행을 직접 읽을 수 있다.

<br><br>

## **인덱스 생성**

<br>

* ### 인덱스 생성은 'CREATE INDEX' 문을 사용해서 생성이 가능하다.

<br>

* ### 인덱스를 생성할 때 한 개 이상의 컬럼을 사용해서 생성할 수 있다.

<br>

* ### 인덱스 키는 기본적으로 오름차순으로 정렬하고 'DESC' 구를 포함하면 내림차순으로 정렬한다.

<br>

```sql
CREATE INDEX IND EMP ON
        EMP (ENAME ASC, SAL DESC);
```

* ### 위의 예는 ENAME에 대해서 오름차순으로 정렬하고 SAL은 내림차순으로 정렬하는 인덱스를 생성하는데, ENAME의 ASC는 생략 가능하다.

<br><br>

## **인덱스 스캔(Index Scan)**

<br>

## 인덱스 유일 스캔(Index Unique SCAN)


<br>

* ### Unique Index SCAN은 인덱스의 키 값이 중복되지 않는 경우, 해당 인덱스를 사용할 때 발생된다.

<br>

* ### 예를 들어 EMPNO(사원번호)가 중복되지 않는 경우 특정 하나의 EMPNO를 조회한다.

<br><br>

## **인덱스 범위 스캔(Index Range SCAN)**

<br>

* ### Index Range SCAN은 SELECT 문에서 특정 범위를 조회하는 WHERE문을 사용한 경우 발생하며, Like, Between이 대표적인 예이다.

<br>

* ### 데이터 양이 적은 경우는 인덱스 자체를 실행하지 않고 TABLE FULL SCAN이 될 수 있다.

<br>

* ### Index Range SCAN은 인덱스의 Leaf Block의 특정 범위를 스캔한 것이다.

<br><br>

## **인덱스 전채 스캔(Index Full SCAN)**

<br>

* ### Index Full SCAN은 인덱스에서 검색되는 인덱스 키가 많은 경우에 Leaf Block의 처음부터 끝까지 전체를 읽어 들인다.