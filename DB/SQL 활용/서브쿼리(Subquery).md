# **서브쿼리(Subquery)**

<br>

* ### Subquery는 SELECT문 내에 다시 SELECT문을 사용하는 SQL문이다.

<br>

* ### Subquery의 형태는 FROM 구에 SELECT문을 사용하는 인라인 뷰(View)와 SELECT문에 Subquery를 사용하는 스칼라 서브쿼리(Scala Subquery) 등이 있다.

<br>

* ### WHERE구에 SELECT문을 사용하면 서브쿼리(Subquery)라고 한다.

<br>

```sql
SELECT * FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DEPTNO=10);
```

<br>

* ### 위으 예에서 WHERE구에 있는 SELECT문은 서브쿼리(Subquery)이고 괄호 내에 SELECT문을 사용한다.

<br>

* ### 서브쿼리 밖에 있는 SELECT문은 메인쿼리(Main Query)이다.

<br>

```sql
SELECT * FROM (SELECT ROWNUM NUM, ENAME FROM EMP) a
WHERE NUM < 5;
```

<br>

* ### FROM구에 SELECT문을 사용하여 가상의 테이블을 만드는 효과를 얻을 수 있다.

<br>

* ### 이렇게 FROM 구에 SELECT문을 사용한 것이 인라인 뷰(Inline VIew)이다.

<br><br>

## **단일 행 Subquery와 다중 행 Subquery**

<br>

* ### 서브쿼리(Subquery)는 반환하는 행 수가 한 개인 것과 여러 개인 것에 따라서 단일 행 서브쿼리와 멀티 행 서브쿼리로 분류된다.

<br>

* ### 단일 행 서브쿼리는 단 하나의 행만 반환하는 서브쿼리로 비교 연산자(=,<,<=,>,>=,<>)를 사용한다.

<br>

* ### 다중 행 서브쿼리는 여러 개의 행을 반환하는 것으로 IN, ANY, ALL, EXISTS를 사용해야 한다.

<br>

<br>

## **다중 행(Multi row) Subquery**

<br>

* ### 다중 행 서브쿼리(Multi row Subquery)는 서브쿼리 결과가 여러 개의 행을 반환하는 것으로 다중 행 연산자를 사용해야 한다.

<br>

* ### 다중 행 비교 연산자

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/65cc948f-b482-4b40-a965-4645c21c32f7/image.png)

<br><br>

## **스칼라(Scala) Subquery**

<br>

* ### 스칼라 Subquery는 반드시 한 행과 한 컬럼만 반환하는 서브쿼리이다.

<br>

* ### 만약 여러 행이 반환되면 오류가 발생한다.

<br>

```sql
SELECT ENAME AS "이름", SAL AS "급여", (SELECT AVG(SAL) FROM EMP) AS "평균급여" -- 한 개의 행만 조회되어야 하는 스칼라 서브쿼리
FROM EMP
WHERE EMPNO=1000;
```

<br>
<br>

## **연관(Correlated) Subquery**

<br>

* ### 연관 Subquery는 Subquery 내에서 Main Query 내의 컬럼을 사용하는 것을 의미한다.

<br>

```sql
SELECT *
FROM EMP a
WHERE a.DEPTNO = (SELECT DEPTNO FROM DEPT b
WHERE b.DEPTNO=a.DEPTNO); -- Main query에서 데이터를 받아서 Subquery를 실행한다.
```

