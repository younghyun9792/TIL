# **DECODE와 CASE문**

<br>

## **DECODE**

<br>

* ### DECODE문으로 IF문을  구현할 수 있다. 즉 특정 조건이 참이면 A, 거짓이면 B로 응답한다.

<br>

```sql
SELECT DECODE (EMPNO, 1000, 'TRUE', 'FALSE')
FROM EMP;
```

<br>

* ### 위의 예는 EMPNO과 1000을 비교해서 같으면 'TRUE'를, 다르면 'FALSE'를 출력한다.

<br><br>

## CASE

<br>

* ### CASE문은 IF~THEN~ELSE~END의 프로그래밍 언어처럼 조건문을 사용할 수 있다.

<br>

* ### 조건을 WHEN구에 사용하고 THEN은 해당 조건이 참이면 실행되고 거짓이면 ELSE구가 실행된다.

<br>

```sql
SELECT CASE
         WHEN EMPNO = 1000 THEN 'A'
         WHEN EMPNO = 1001 THEN 'B'
         ELSE 'C'
        END
FROM EMP;
```

<br>

* ### 위의 예는 EMPNO가 1000이면 A, 1001이면 B, 나머지들은 C를 출력한다.