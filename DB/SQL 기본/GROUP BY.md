# **GROUP BY**

<br>


## GROUP BY문 사용
<br>


* ### GROUP BY는 테이블에서 소규모 행을 그룹화하여 합계, 평균, 최대 값,최소 값 등을 계산할 수 있다.
  
  <br>

* ### HAVING 구에 조건문을 사용하며, ORDER BY를 사용해 정렬을할 수 있다.

<br>

```sql
SELECT DEPTNO, SUM(SAL)
FROM EMP  
GROUP BY DEPTNO;
```

* ### 위의 예는 SELECT DEPTNO, SAL FROM EMP를 실행한 후, DEPTNO(부서번호)로 그룹을 만들고 그룹별 합계를 계산한다.

<br>

## HAVING문 사용

<br>

* ### GROUP BY문에 조건절을 사용하려면 HAVING을 사용해야 한다. 만약 WHERE절에 조건문을 사용하게 되면 GROUP BY 대상에서 제외된다.

<br>

```sql
SELECT DEPTNO, SUM(SAL) 
FROM EMP 
GROUP BY DEPTNO 
HAVING SUM(SAL) > 10000;
```

* ### 위 예는 GROUP BY 결과에서 SAL의 합계가 10000이상인 것만 조회한다.


<br>

## 집계함수 종류

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/a0a9a4b2-bef0-4cf4-aa44-f7779e2efd9d/image.png)

<br><br>

## GROUP BY 사용 예제

<br>

* ### 부서별(DEPTNO), 관리자별(MGR) 급여 평균 계산
  * 부서별, 관리자별 급여 평균이므로 GROUP BY에 부서와 관리자를 추가한다.
  * 평균을 계산하기 위해서 SELECT 문에 AVG 함수를 사용한다.

<br>

```sql
SELECT DEPTNO, MGR, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, MGR;
```

<br>

* ### 직업별(JOB) 급여 합계 중에 급여 합계(SAL)가 1000 이상인 직원
  * 직업별 급여 합계이므로 GROUP BY에 JOB을 포함시키고, 급여 하계가 1000 이상만 조회해야 하므로 HAVING 조건을 추가한다.

<br>

```sql
SELECT JOM, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING SUM(SAL) > 1000;
```

<br>

* ### 사원번호 1000~1003번의 부서별 급여 합계
  * 사원번호 1000번에서 1003번 사이까지 조회를 해야 하므로 WHERE문에 조건을 추가한다.
  * 그리고, 부서별 합계이므로 GROUP BY에 DEPTNO를 사용하고 SELECT문에 SUM 함수를 사용한다.

<br>

```sql
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO;
```