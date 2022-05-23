# **그룹 함수(Group Function)**

<br>

## **ROLLUP**

<br>

* ### ROULLUP은 GROUP BY의 컬럼에 대해서 Subtotal을 만들어준다.

<br>

* ### ROLLUP을 할 때 GROUP BY 구에 컬럼이 두 개 이상 오면 순서에 따라서 결과가 달라진다.

<br>

```sql
SELECT DECODE(DEPTNO, NULL, '전체합계', DEPTNO), SUM(SAL) -- DEPTNO가 NULL이면 '전체합계'를 출력한다.
FROM EMP
GROUP BY ROLLUP(DEPTNO); -- ROLLUP을 사용하면 부서별 합계 및 전체합계가 계산된다.
```

<br>

```sql
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB); -- 부서별, 직업별, 전체 합계가 모두 조회된다.
```

<br><br>

## **GROUPING 함수**

<br>

* ### GROUPING 함수는 ROLLUP, CUBE, GROUPING SETS에서 생성되는 합계 값을 구분하기 위해 만들어진 함수이다.

<br>

* ### 예를 들어 소계, 합계 등이 계산되면 GROUPING 함수는 1을 반환하고 그렇지 않으면 0을 반환해서 합계 값을 식별할 수 있다.

<br>

```sql
SELECT DEPTNO, GROUPING(DEPTNO), OB, GROUPING(JOB), SUM(SAL)
FROM EMP
GROUP BY ROLLUP (DEPTNO);
```

<br>

* ### GROUPING의 반환 값을 DECODE 혹은 CASE문으로 식별해서 SELECT문으로 "소계", "합계 등을 구분하는 것이다.

<br>

```sql
SELECT DEPTNO,
DECODE(GROUPING(DEPTNO),1,'전체합계') TOT,
DECODE(GROUPING(JOB),1,'부서합계') T-DEPT, -- DECODE를 사용해서 전체 합계와 부서 합계를 구분한다.
SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);
```

<br><br>

## **GROUPING SETS 함수**

<br>

* ### GROUPING SETS 함수는 GROUP BY에 나오는 컬럼의 순서와 관계없이 다양한 소계를 만들 수 있다.

<br>

* ### GROUPING SETS 함수는 GROUP BY에 나오는 컬럼의 순서와 관계없이 개별적으로 모두 처리한다.

<br>

```sql
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB);-- DEPTNO와 JOB을 각각의 그룹으로 합계를 계산한다.
```

<br><br>

## **CUBE 함수**

<br>

* ### CUBE는 CUBE 함수에 제시한 컬럼에 대해 결합 가능한 모든 집계를 계산한다.

<br>

* ### 다차원 집계를 제공하여 다양하게 데이터를 분석할 수 있게 한다.

<br>

* ### 예를 들어 부서와 직업을 CUBE로 사용하면 부서별, 직업별, 부서별 직업별, 전체 합계가 조회된다. 즉, 조합할 수 있는 경우의 수가 모두 조합된다.

<br>

```sql
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);
```

<br>