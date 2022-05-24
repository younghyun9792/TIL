# **옵티마이저 조인(Optimizer Join)**

<br>

## **Netsted Loop 조인**

<br>

* ### Nested Loop 조인은 하나의 테이블에서 데이터를 먼저 찾고 그다음 테이블을 조인하는 방식으로 실행된다.

<br>

* ### Nested Loop 조인에서 먼저 조회되는 테이블을 외부 테이블(Outer Table)이라고 학, 그다음 조회되는 테이블을 내부 테이블(Inner Table)이라고 한다.

<br>

* ### Nested Loop 조인에서는 외부 테이블(선행 테이블)의 크기가 작은 것을 먼저 찾는 것이 중요하다. 그래야 데이터가 스캔되는 범위를 줄일 수 있기 떄문이다.

<br>

* ### Nested Loop 조인은 RANDOM ACCESS가 발생하는데 RANDOM ACCESS가 많이 발생하면 성능 지연이 발생한다. 그러므로 Nested Loop 조인은 RANDOM ACCESS의 양을 줄여야 성능이 향상된다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/6981da68-c869-4ce6-9e87-b7b0eaf77685/image.png)

<br>

* ### 위의 예는 Nested Loop 조인 방식을 도식화한 것이다. 즉, T_CUST_SALE의 인덱스를 먼저 검색하고 T_CUST_SALE 인덱스에 있는 ROWID를 사용해서 T_CUST_SALE 테이블을 읽는다.

<br>

* ### 그 다음은 T_CUST_SALE에서 T_CUST_MAST 테이블의 인덱스를 찾는다. 이 부분을 RANDOM ACCESS라고 한다.

<br>

* ### T_CUST_MAST 인덱스를 사용해서 다시 T_CUST_MAST 테이블에서 데이터를 찾는다. 여기까지 실행되면 모든 데이터를 다 찾은 것이다. 그 뒤, 인출(Fetch)를 실행해서 전송한다.

<br>

```sql
SELECT /*+ ordered use_nl(b) */ *
FROM EMP a, DEPT b
WHERE a.DEPTNO = b.DEPTNO
AND a. DEPTNO = 10;
```

<br>

* ### 위의 예는 use_nl 힌트를 사용해서 의도적으로 Nested Loop 조인을 실행했는데, 실행계획을 볼 시 EMP 테이블을 먼저 FULL SCAN 하고 그 다음 DEPT 테이블을 FULL SCAN 하여 Nested Loop 조인을 하는 것이다.

<br>

* ### ordered 힌트는 FROM절에 나오는 테이블 순서대로 조인을 하게 하는 것으로, 혼자 사용되지 않고 use_nl, use_merge, use_hash 힌트와 함꼐 사용된다.

<br><br>

## **Sort Merge 조인**

<br>

* ### Sort Merge 조인은 두 개의 테이블을 SORT_AREA라는 메모리 공간에 모두 로딩(Loading)하고 SORT를 수행한다.

<br>

* ### 두 개의 테이블에 대해서 SORT가 완료되면 두 개의 테이블을 병합(Merge)한다.

<br>

* ### Sort Merge 조인은 정렬(SORT)이 발생하기 때문에 데이터양이 많아지면 성능이 떨어지게 된다.

<br>

* ### 정렬 데이터량이 너무 많으면 정렬은 임시 영역에서 수행되며, 임시 영역은 디스크에 있기 때문에 성능이 급격히 떨어진다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/8bbd2dda-8993-4a23-88df-6790f0e90bba/image.png)

<br>

```sql
SELECT /*+ ordered use_merge(b) */ *
FROM EMP a, DEPT b
WHERE a.DEPTNO = b.DEPTNO
AND a.DEPTNO = 10;
```

<br>

* ### 위의 예는 데이터베이스 힌트를 사용해서 의도적으로 SORT MERGE 조인을 한 것으로 use_merge 힌트를 사용해서 SORT METGE 조인을 할 수 있다. 단, use_merge 힌트는 ordered 힌트와 같이 사용해야 한다.

<br><br>

## **Hash 조인**

<br>

* ### Hash 조인은 두 개의 테이블 중에서 작은 테이블을 HASH 메모리에 로딩하고 두 개의 테이블의 조인 키를 사용해서 해시 테이블을 생성한다.

<br>

* ### Hash 조인은 해시함수를 사용해서 주소를 계산하고 해당 주소를 사용해서 테이블을 조인하기 때문에 CPU 연산을 많이 한다.

<br>

* ### 특히 Hash 조인 시에는 선행 테이블이 충분히 메모리에 로딩되는 크기여야 한다.

<br>

```sql
SELECT /*+ ordered use_hash(b) */ *
FROM EMP a, DEPT b
WHERE a.DEPTNO = b.DEPTNO
AND a.DEPTNO = 10;
```