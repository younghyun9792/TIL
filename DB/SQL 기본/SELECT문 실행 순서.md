# **SELECT문 실행 순서**

<br>

* ### SQL의 실행 순서는 결과로 조회된 데이터를 이해하는 데 아주 중요한 요소이다.

<br>

* ### SELECT문의 작성 순서는 아래와 같다.

<br>

```sql
SELECT ename -- SELECT 컬럼명
FROM emp -- FROM 테이블명
WHERE empno=10 -- WHERE 조건식
GROUP BY ename -- GROUP BY 컬럼명
HAVING count(*) >= 1 -- HAVING 조건식
ORDER BY ename; -- ORDER BY 컬럼명
```

<br><br>

* ### SELECT문의 실행 순서는 아래와 같다.

<br>

### 1. FROM(조회 테이블 확인)
### 2. WHERE(데이터 추출 조건 확인)
### 3. GROUP BY(컬럼 그룹화)
### 4. HAVING(HAVING)
### 5. SELECT(데이터 추출)
### 6. ORDER BY(데이터 순서 정렬)