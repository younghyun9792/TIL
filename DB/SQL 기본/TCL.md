# **TCL(Transaction Control Language)**

<br>

* ### TCL(Transaction Control Language)란 논리적인 작업의 단위를 묶어서 DML에 의해 조작된 결과를 작업단위(트랜잭션) 별로 제어하는 명령어이다.

<br>
<br>

## **COMMIT**

<br>

* ### COMMIT은 INSERT, UPDATE, DELETE문으로 변경한 데이터를 데이터베이스에 반영한다.

<br>

* ### 변경 전 데이터는 잃어버린다. 즉, A값을 B로 변경하고 COMMIT을 할 시 A는 잃어버리고 B를 반영한다.

<br>

* ### 다른 모든 데이터베이스 사용자는 변경된 데이터를 볼 수 있다.

<br>

* ### COMMIT이 완료되면 DB 변경으로 인한 LOCK이 UNLOCK되며, 다른 모든 데이터베이스 사용자는 변경된 데이터를 조작할 수 있다.

<br>

* ### COMMIT을 실행하면, 하나의 트랜잭션 과정을 종료한다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/e479ca6f-e2b3-4382-8cf4-00b737d21afd/image.png)

```sql
INSERT INTO EMP VALUES(1000, '임베스트');
UPDATE EMP SET ENAME='조조' WHERE EMPNO=100;
DELETE FROM EMP WHERE EMPNO=100;
COMMIT; -- 위 내용을 데이터베이스에 반영한다.
```

<br>

> * ### Auto Commit
> * SQL*PLUS 프로그램을 정상적으로 종료하는 경우 자동으로 Commit 된다.
> * DDL 및 DCL을 사용하는 경우 자동으로 Commit 된다.
> * 'set autocommit on;'을 실행 시 자동으로 Commit 된다.


<br><br>
- - -

<br>


## **ROLLBACK**

<br>

* ### ROLLBACK을 실행하면 데이터에 대한 변경 사용을 모두 취소하고 트랜잭션을 종료한다.

<br>

* ### INSERT, UPDATE, DELETE문의 작업을 모두 취소한다. 단, 이전에 COMMIT한 곳까지만 복구한다.
  
<br>

* ### ROLLBACK을 실행하면 LOCK이 해제되고 다른 사용자도 데이터베이스 행을 조작할 수 있다.

<br>

```sql
INSERT INTO EMP VALUES(1000, '임베스트');
UPDATE EMP SET ENAME='조조' WHERE EMPNO=100;
DELETE FROM EMP WHERE EMPNO=100;
ROLLBACK; -- 변경된 사항을 취소하고, 이전 COMMIT으로 돌아간다.
```

<br><br>

- - -

<br>

## **SAVEPOINT(저장점)**

<br>

* ### SAVEPOINT는 트랜잭션을 작게 분할하여 관리하는 것으로 SAVEPOINT를 사용하면 지정된 위치까지만 트랜잭션을 ROLLBACK 할 수 있다.

<br>

* ### SAVEPOINT의 지정은 SAVEPOINT <SAVEPOITT명>을 실행한다.

<br>

* ### 지정된 SAVEPOINT까지만 데이터 변경을 취소하고 싶은 경우는 'ROLLBACK TO <SAVEPOINT명>'을 입력하면 되지만, 'ROLLBACK'을 실행할 경우 SAVEPOINT와는 관계없이 변경된 모든 데이터를 취소한다.
