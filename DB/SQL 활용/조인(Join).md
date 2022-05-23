 # **조인(Join)**

 <br>

## EQUI(등가) 조인(교집합)

<br>

* ### 조인은 여러 개의 릴레이션을 사용해서 새로운 릴레이션을 만드는 과정이다.

<br>

* ### 조인의 가장 기본은 교집합을 만드는 것이다.

<br>

* ### 두 개의 테이블 간에 일치하는 것을 조인시킨다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/305f3d92-64a4-409c-a787-9ec68f269739/image.png)

<br>

* ### EQUI 조인은 EMP 테이블과 DEPT 테이블에서 DEPTNO 컬럼을 사용해 같은 것만 조인한다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/ab956d82-a714-4a5c-b415-9b69e0ab872e/image.png)

<br>


* ### 위의 예를 보면 EMP 테이블의 DEPTNO과 DEPT테이블의 DEPTNO가 같은 것을 사용하여 조인한다.

<br>

```sql
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;-- '='을 사용하여 두 개의 테이블을 연결한다.
```

<br>

* ### EQUI 조인은 '='을 사용하여 두 개의 테이블을 연결한다.

<br>

```sql
SELECT * FROM EMP, DEPTNO
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.ENAME LIKE '임%'
ORDER BY ENAME; -- 조인문에 추가조건 및 정렬을 할 수 있다
```

<br><br>

## **INNER JOIN**

<br>

* ### EQUI 조인과 마찬가지로 ISO 표준 SQL로 INNER JOIN이 있다. INNER JOIN은 ON구를 사용해서 테이블을 연결한다.

<br>

```sql
SELECT * FROM EMP INNER JOIN DEPT -- INNER JOIN구로 테이블을 정의한다.
ON EMP.DEPTNO = DEPT.DEPTNO; -- ON구를 사용하여 조인 조건을 넣는다.
```

<br>

```sql
SELECT * FROM EMP, DEPTNO
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.ENAME LIKE '임%'
ORDER BY ENAME; -- 조인문에 추가조건 및 정렬을 할 수 있다
```

<br>

* ### EQUI조인을 한 후에 실행 계획을 확인하여 두 개의 테이블을 어떻게 연결했는지 확인할 수 있다.

<br><br>

## **INTERSECT 연산**

<br>

* ### INTERSACT 연산은 두 개의 테이블에서 교집합을 조회한다.

<br>

* ### 즉, 두 개의 테이블에 공통된 값을 조회한다.

<br>

```sql
SELECT DEPTNO FROM EMP
INTERSACT -- 교집합 조회
SELECT DEPTNO FROM DEPT;
```

<br><br>

## **Non-EQUI(비등가) 조인**

<br>

* ### Non-EQUI 조인은 두 개의 테이블 간에 조인하는 경우 '='을 사용하지 않고 '>','<', '>=', '<=' 등을 사용한다.

<br>

* ### 즉, Non-EQUI 조인은 정확하게 일치하지 않는 것을 조인하는 것이다.

<br><br>

## **OUTER JOIN**

<br>

* ### Outer Join은 두 개의 테이블 간에 교집합(EQUI Join)을 조회하고 한쪽 테이블에만 있는 값도 포함시켜서 조회한다.

<br>

* ### 예를 들어 DEPT 테이블과 EMP 테이블을 Outer Join하면 DEPTNO가 같은 것을 조회하고 DEPT테이블에만 있는 DEPTNO도 포함시킨다.

<br>

* ### 이떄 왼쪽 테이블에만 있는 행도 포함하면 Left Outer Join이라고 하고, 오른쪽 테이블에만 있는 행만 포함시키면 Right Outer Join이라고 한다.

<br>

* ### FULL Outer Join은 Left Outer Join과 Right Outer Join 모두를 하는 것이고, Oracle DB에서는 Outer Join을 할 때 '(+)' 기호를 사용해서 할 수 있다.

<br>

```sql
SELECT * FROM DEPT, EMP
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO; -- LEFT OUTER JOIN
```

<br><br>

## **CROSS JOIN**

<br>

* ### CROSS JOIN은 조인 조건 없이 2개의 테이블을 하나로 조인한다.

<br>

* ### 조인구가 없기 떄문에 카테시안 곱이 발생한다.(Ex. 행이 14개 있는 테이블과 행이 4개 있는 테이블을 조회 시 56개의 행이 조회)

<br>

* ### CROSS JOIN은 FROM 절에 "CROSS JOIN"구를 사용하면 된다.

<br>

```sql
SELECT * FROM CROSS JOIN DEPT;
```

<br><br>

## **UNION을 이용한 합집합 구현**

<br>

## UNION

<br>

* ### UNION 연산은 두 개의 테이블을 하나로 만드는 연산이다.

<br>

* ### 즉, 두 개의 테이블을 하나로 합치는 것이며, 주의사항은 두 개의 테이블의 컬럼 수, 컬럼의 데이터 형식이 모두 일치해야 하며, 만약 두 개의 테이블에 UNION 연산이 사용될 떄 둘 중 하나라도 다르면 오류가 난다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/156054bd-60de-4c07-b9bf-4d86a5a9af31/image.png)

<br>

* ### UNION 연산은 두 개의 테이블을 하나로 합치면서 중복된 데이터를 제거하는데, 그래서 UNION은 정렬(SORT) 과정을 발생시킨다.

<br>

```sql
SELECT DEPTNO FROM EMP
UNION -- 중복된 데이터를 제거하면서 합침.
SELECT DEPTNO FROM EMP;
```

<br>

## UNION ALL

<br>

* ### UNION ALL은 두 개의 테이블을 하나로 합치면서 UNION처럼 중복을 제거하거나, 정렬을 하지 않는다.

<br>

```sql
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM EMP;
```

<br><br>

## **차집합을 만드는 MINUS**

<br>

* ### MINUS 연산은 두 개의 테이블에서 차집합을 조회하는데, 즉 먼저 쓴 SELECT문에는 있고 뒤에 쓴 SELECT 문에는 없는 집합을 조회한다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/4c43d0c0-53e8-442e-9f91-99e69ecce3a1/image.png)

<br>

```sql
SELECT DEPTNO FROM DEPT -- 10,20,30,40이 있음
MINUS
SELECT DEPTNO FROM EMP; -- 10, 20, 30이 있음, 즉 중복되지 않는 40이 출력
```