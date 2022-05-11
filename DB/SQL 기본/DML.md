# **DML(Data Manipulation Language)**

<br>

## **INSERT문**
<br>

* ### INSERT 문은 테이블에 데이터를 입력하는 DML 문이다.

```sql
INSERT INTO table (column1, column2, ...) VALUES (expression1, expression2, ...);
```

* ### 기본적으로 이런 구조며, EMP 테이블에 데이터를 입력하려면 아래와 같이 하면 된다.  
  <br>

```sql
INSERT INTO EMP(EMPNO, ENAME) VALUES(1000,'임베스트');
```

* ### 데이터를 입력할 때 문자열을 입력하는 경우 작은 따옴표(' ')를 사용해야 한다.  
  <br>
* ### 만약 특정 테이블의 모든 컬럼에 삽입하는 경우, 컬럼명은 생략할 수 있다.

<br>

```sql
INSERT INTO EMP VALUES(1000, '임베스트');
```
<br>

* ### 주의사항으론 INSERT 문 실행 후 최종적으로 데이터를 저장하려면 TCL 문인 Commit을 실행해야 하며, Auto Commit 상태인 경우엔 실행하지 않아도 저장이 된다.
  
  <br><br><br>

### **SELECT문으로 입력**

<br>

```sql
INSERT INTO DEPT_TEST
    SELECT * FROM DEPT;
```

* ### SELECT 문으로 조회한 값을 INSERT로 바로 넣을 수 있다.

<br><br>

### **Nologging 사용**

<br>

```sql
ALTER TABLE DEPT Nologging;
```

* ### DB에서는 데이터를 입력하면 로그파일에 그 정보를 기록한다.
* ### Check point라는 이벤트가 발생 시 로그파일의 데이터를 데이터 파일에 저장한다.
* ### Nologging 옵션은 로그파일의 기록을 최소화시켜서 입력 시 성능을 향상시키는 방법으로, Buffer Cache라는 메모리 영역을 생략하고 기록한다.

<br><br><br>

## **UPDATE문**

<br>

* ### UPDATE문은 입력된 데이터의 값을 수정하는 DML문이다.
* ### UPDATE문은 원하는 조건에 해당하는 데이터를 수정하는데, 조건을 입력하지 않으면 모든 데이터가 수정되므로 주의해야 한다.
<br>

```sql
UPDATE EMP -- 테이블명
    SET ENAME='조조' -- 수정 정보
    WHERE EMPNO=100; -- 어떤 대상을 수정시킬지 조건
```

<br>

* ### 위의 예에서 EMPNO=100인 사람이 2명이면 2명의 직원이 ENAME='조조'로 수정된다.
  
<br><br><br>

## **DELETE문**

<br>

* ### DELETE문은 원하는 조건을 검색해서 해당되는 행을 삭제하는 DML이다.
* ### DELETE도 UPDATE처럼 조건을 입력하지 않으면 모든 데이터가 삭제되므로, 주의해야한다.

<br>

```sql
DELETE FROM EMP
    WHERE EMPNO=100;
```

<br>

* ### 위의 예는 EMP테이블의 EMPNO=100인 데이터를 삭제시킨다는 건데, WHERE문을 입력하지 않으면 모든 데이터가 삭제된다.

<br><br>

## 테이블의 모든 데이터 삭제

<br>

```sql
DELETE FROM 테이블명;
```

* ### 테이블의 모든 데이터를 삭제시키지만, 데이터가 삭제되어도 테이블의 용량은 감소되지 않는다.

<br>

```sql
TRUNCATE TABLE 테이블명;
```

* ### 테이블의 모든 데이터를 삭제하며, 데이터가 삭제되면 테이블의 용량은 초기화된다.

<br><br><br>

## **SELECT문**

<br>

```sql
SELECT * -- 조회를 원하는 컬럼(*은 모든 컬럼)
FROM EMP -- 조회를 원하는 테이블
WHERE 사원번호 = '100'; -- 원하는 조건
```

<br><br>

## SELECT 컬럼 지정
<br>

* ### SELECT EMPNO, ENAME FROM EMP;
  EMP 테이블의 모든 행에서 EMPNO과 ENAME 컬럼을 출력한다.  

* ### SELECT * FROM EMP;
  EMP 테이블의 모든 칼럼과 모든 행을 출력한다.  

* ### SELECT ENAME || '님' FROM EMP;
  EMP 테이블의 모든 행에서 ENAME 컬럼을 조회하는데, ENAME 컬럼 뒤에 '님'이라는 문자를 결합한다.

<br><br>

## Order by를 사용한 정렬

<br>

* ### SELECT문을 사용할 때 Order by를 같이 사용할 수 있는데, Order by가 정렬을 하는 시점은 모든 실행이 끝난 후 데이터를 출력하기 바로 전이다.
* ### 정렬을 할 때 메모리를 많이 사용하게 되는데, 정렬을 회피하긴 위해선 인덱스(Index)를 사용해야 하며, 인덱스를 생성할 때 사용자가 원하는 형태로 오름차순 혹은 내림차순으로 생성해야 한다.
* ### 특별한 지정이 없으면 Order by는 오름차순으로 설정한다.

<br>

```sql
SELECT * FROM EMP
    ORDER BY ENAME, SAL DESC;
```
* ### 기본이 ASC(오름차순)이기 때문에, ENAME부분은 ENAME ASC와 같으며, SAL DESC처럼 내림차순으로 설정하고 싶을 땐 DESC를 입력한다.

<br><br>


## Index를 사용한 정렬 회피
<br>

```sql
create table emp(
    empno   number(10) primary key,
    ename   varchar2(20),
    sal     number(10)
);

insert into emp values(1000, '임베스트', 20000);
insert into emp values(1001, '조조', 20000);
insert into emp values(1002, '관우', 20000);
```
<br>

* ### 위와 같이 데이터를 입력하면, EMPNO가 기본키이므로 자동으로 오름차순 인덱스를 생성해서 EMPNO로 오름차순 정렬되어서 조회된다.

<br>

```sql
SELECT /*+ INDEX_DESC(A) */ -- Index 힌트
FROM EMP A;
```

* ### 위의 예처럼 SQL문을 사용하면 INDEX 힌트(Hint)를 이용해 EMPNO 인덱스를 내림차순으로 읽는다.
<br><br>

## **Distinct와 Alias**

<br>

* ## Distinct
  ### Distinct는 컬럼명 앞에 지정하여 중복된 데이터를 한 번만 조회하게 한다.

  <br>
```sql
SELECT DEPTNO FROM EMP ORDER BY DEPTNO;
```

* ### 원래 이렇게 했을 때 중복된 값이 있었다면

<br>

```sql
SELECT DISTINCT DEPTNO FROM EMP ORDER BY DEPTNO;
```

* ### 이렇게 할 시 DEPTNO 값의 중복이 사라진다.

<br><br>

* ## Alias
  ### Alias는 테이블명이나 컬럼명이 너무 길어서 간략하게 사용할 떄 사용한다.

  <br>

```sql
SELECT ENAME AS "이름" FROM EMP a -- AS "이름"으로 ENAME을 "이름"으로 출력되게함. EMP 테이블명 대신 'a'를 사용
WHERE a.EMPNO=1000; -- 'ㅁ'를 테이블명 처럼 사용함. 
```