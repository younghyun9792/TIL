# **WHERE문 사용**

<br>

## **WHERE문이 사용하는 연산자**

<br>

* ### 비교 연산자

![이미지](https://velog.velcdn.com/images/as979200/post/6a8e4641-1bb1-4fb9-96d7-314f3ef3574b/image.png)

<br>

* ### 부정 비교 연산자

![이미지](https://velog.velcdn.com/images/as979200/post/64247937-07a1-460e-98b4-43c77d930133/image.png)

<br>

* ### 논리 연산자

![이미지](https://velog.velcdn.com/images/as979200/post/d29956ab-ab75-420e-9846-cc100f6be670/image.png)

<br>

* ### SQL 연산자

![이미지](https://velog.velcdn.com/images/as979200/post/c2c60bed-1af1-4107-84b8-f6ea47f7113b/image.png)

<br>

* ### 부정 SQL 연산자

![이미지](https://velog.velcdn.com/images/as979200/post/0b290447-ccc1-448f-ab8a-0a30f700997a/image.png)

<br><br><br>

## **Like문 사용**

<br>

* ### 와일드 카드

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/cc1166f2-3a12-45b4-873a-bc1da4643f7f/image.png)

<br>

* ### Like문 예시

<br>

```sql
SELECT * FROM EMP
WHERE ENAME LIKE 'test%';
```
### ENAME이 'test'로 시작하는 모든 데이터를 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE ENAME LIKE '%1';
```
### ENAME이 '1'로 끝나는 모든 데이터를 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE ENAME LIKE '%est%';
```
### ENAME의 중간에 'est'가 들어가는 모든 데이터를 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE ENAME LIKE 'test';
```
### 와일드카드 없이 사용 시 = 연산자와 같다. 'test'만 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE ENAME LIKE 'test_';
```
### ENAME이 'test'로 시작하는 하나의 글자만 더 있는 모든 데이터를 조회한다.

<br><br><br>

## **Between문 사용**

<br>

* ### Between문 예시

<br>

```sql
SELECT * FROM EMP
WHERE SAL BETWEEN 1000 AND 2000;
```
### SAL값이 1000이상 2000이하인 모든 데이터를 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE SAL NOT BETWEEN 1000 AND 2000;
```
### SAL값이 1000이상 2000이하가 아닌 모든 데이터를 조회한다.

<br><br><br>

* ## **IN문 사용**

<br>

* ### IN은 'OR'의 의미를 가지고 있어서 하나의 조건만 만족해도 조회가 된다.
* ### 예를 들어 JOB이 "CLERK"이거나 "MANAGER"인 것을 조회할 때 "JOB IN ('CLERK','MANAGER')" 를 사용한다.

<br>

* ### **In문 예시**

<br>

```sql
SELECT * FROM EMP
WHERE JOB IN ('CLERK','MANAGER');
```
### JOB이 CLERK이거나 MANAGER인 것을 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE (JOB,ENAME)
IN (('CLEAK','test1'),('MANAGER','test4'));
```
### JOB이 CLERK이거나 MANAGER이고, ENAME이 test1이거나 test4인 것을 조회한다.

<br><br><br>

## **NULL값 조회**

<br>

### **NULL의 특징**
* NULL은 모르는 값을 의미한다.
* NULL은 값의 부재를 의미한다.
* NULL과 모든 비교는 알 수 없음을 반환한다.
* NULL과 숫자 혹은 날짜를 더하면 NULL이 된다.
* NULL 값은 비교 연산자로 비교할 수 없다. 만약 비교 연산자로 NULL을 비교할 시 거짓(False)이 나온다.

<br>

### **NULL 값 조회**

<br>

```sql
SELECT * FROM EMP
WHERE MGR IS NULL;
```
### MGR 컬럼이 NULL인 것을 조회한다.

<br>

```sql
SELECT * FROM EMP
WHERE MGR IS NOT NULL;
```
### MGR 컬럼이 NULL이 아닌 것을 조회한다.

<br>

* ### NULL 함수

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/30810f1c-11d3-43b4-b6cf-2c1901bff6e0/image.png)