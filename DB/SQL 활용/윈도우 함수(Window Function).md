# **윈도우 함수(Window Function)**

<br>

* ### 윈도우 함수는 행과 행 간의 관계를 정의하기 위해 제공되는 함수로, 순위, 합계, 평균, 행 위치 등을 조작할 수 있다.

<br>

* ### 윈도우 함수 구조 
  
<br>


```sql
SELECT WINDOW_FUNCTION(ARGUMENTS)
    OVER (PARTITION BY 컬럼
        ORDER BY WINDOWING 절)
FROM 테이블명;
```

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/59a3621c-c6b4-48a1-8d1e-3f3039b14a96/image.png)

<br>

* ### WINDOWING

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/ba4d03eb-42cd-47f9-8138-ef8df7081c6f/image.png)

<br>

```sql
SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL
                ROWS BETWEEN UNBOUNCED PRECEDING -- 첫 번째 행을 의미한다
                AND UNBOUNCED FOLLOWING -- 마지막 행을 의미한다.
                ) TOTSAL
FROM EMP; -- 전체 합계를 조회한다.
```

<br>

```sql
SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL
                ROWS BETWEEN UNBOUNCED PRECEDING -- 첫 번째 행을 의미한다
                AND CURRENT ROW -- 현재 행을 의미한다.
                ) TOTSAL
FROM EMP; -- 행 별로 누적 합을 조회한다.
```

<br>

```sql
SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL
                ROWS BETWEEN CURRENT ROW -- 현재 행을 의미한다.
                AND UNBOUNCED FOLLOWING -- 마지막 행을 의미한다.
                ) TOTSAL
FROM EMP; -- 현재 행부터 마지막 행까지의 합계를 조회한다.
```

<br><br>

## **순위 함수(RANK Function)**

<br>

* ### 윈도우 함수는 특정 항목과 파티션에 대해서 순위를 계산할 수 있는 함수를 제공한다.

<br>

* ### 순위 함수는 RANK, DENSE_RANK, ROW_NUMBER 함수가 있다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/9aa9c29e-3eb6-426e-9dc1-07f636aa65c4/image.png)


<br>

```sql
SELECT ENAME, SQL,
    RANK() OVER (ORDER BY SAL DESC) ALL RANK,-- 급여 순위를 계산한다. 동일한 순위는 동일하게 조회한다.
    RANK() (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK -- 직업별 순위를 구한다.
FROM EMP;
```

<br>

```sql
SELECT ENAME, SQL,
    RANK() OVER (ORDER BY SAL DESC) ALL RANK,-- 급여 순위를 계산한다. 동일한 순위는 동일하게 조회한다.
    DENSE_RANK() (ORDER BY SAL DESC) DENSE_RANK -- 동일한 순위를 하나의 건수로 계산한다.
FROM EMP;
```

<br>

```sql
SELECT ENAME, SQL,
    RANK() OVER (ORDER BY SAL DESC) ALL RANK,-- 급여 순위를 계산한다. 동일한 순위는 동일하게 조회한다.
    ROW_NUMBER() (ORDER BY SAL DESC) ROW_NUM -- 동일한 순위에 다른 고유한 순위를 부여한다.
FROM EMP;
```

<br><br>

## **집계함수(RANK Function)**

<br>

* ### 집계(AGGREGATE) 관련 윈도우 함수

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/48e11e9e-3190-4720-80f0-e49d64225069/image.png)

<br><br>

## **행 순서 관련 함수**

<br>

* ### 행 순서 관련 함수는 상위 행의 값을 하위에 출력하거나 하위 행의 값을 상위 행에 출력할 수 있다.

<br>

* ### 특정 위치의 행을 출력할 수 있다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/82fe79d4-2ea7-407c-8bf3-221a9f5531a8/image.png)

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNCED PRECEDING) AS DEPT_A -- 부서 내에서 급여가 가장 많은 사람을 의미한다. 내림차순 시 가장 큰 값이 맨 위로 오기 때문에, FIRST_VALUE로 가져올 시 가장 큰 값을 가져온다.
FROM EMP;
```

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNCED PRECEDING) AS DEPT_A -- 부서 내에서 급여가 가장 적은 사람을 의미한다. 내림차순 시 가장 적은 값이 맨 아래로 오기 때문에, LAST_VALUE로 가져올 시 가장 적은 값을 가져온다.
FROM EMP;
```

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
    LAG(SAL) OVER (ORDER BY SAL DESC) AS PRE_SAL -- 이전의 SAL 값을 가져온다.
FROM EMP;
```

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
    LEAD(SAL,2) OVER (ORDER BY SAL DESC) AS PRE_SAL -- 지정된 위치의 값 (SAL에서 2번째 행의 값)을 가져온다.
FROM EMP;
```

<br><br>

## **비율 관련 함수**

<br>

* ### 비율 관련 함수는 누전 백분율, 순서별 백분율, 파티션을 N분으로 분할한 결과 등을 조회할 수 있다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/5a280b88-c20f-4eba-be73-a522d1755a75/image.png)

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
PERCENT_RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERCENT_SAL -- 부서별로 등수의 백분율을 구한다.
FROM EMP;
```

<br>

```sql
SELECT DEPTNO, ENAME, SAL,
NTILE(4) OVER (ORDER BY SAL DESC) AS N_TILE -- 4등분하여 분류한다.
FROM EMP;
```
