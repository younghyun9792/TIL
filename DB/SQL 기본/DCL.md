# **DCL(Data Control Language)**

<br>

* ### DCL(Data Control Language)란 데이터베이스에 접근하는 객체들을 사용하도록 권한을 주고 회수하는 명령어다.

<br>
<br>

## **GRANT**

<br>

* ### GRANT는 데이터베이스에 사용자에게 권한을 부여한다.

<br>

* ### 데이터베이스 사용을 위해서는 권한이 있어야 연결, 입력, 수정, 삭제, 조회를 할 수 있다.

<br>

```sql
GRANT privileges ON object To user; -- privileges는 권한을, object는 테이블명이다.
```

<br>

* ### Privileges(권한)

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/e369f862-a346-4139-bde7-b8ed069e526c/image.png)

<br>

```sql
GRANT SELECT, INSERT, UPDATE, DELETE -- 부여되는 권한이다.
ON EMP -- EMP 테이블에 대해서이다.
TO LIMBEST; -- LIMBEST 사용자에게 부여한다.
```

<br><br>

* ### WITH GRANT OPTION

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/d5108222-c653-4d46-a233-8616d7b12c69/image.png)

<br>

```sql
GRANT SELECT, INSERT, UPDATE, DELETE -- 부여되는 권한이다.
ON EMP -- EMP 테이블에 대해서이다.
TO LIMBEST WITH GRANT OPTION; -- LIMBEST 사용자에게 부여하고, 권한을 부여할 수 있는 권한을 부여한다..
```

<br><br>


- - -

<br>

## **REVOKE**

<br>

* ### REVOKE는 데이터베이스 사용자에게 부여된 권한을 회수한다.

<br>

```sql
REVOKE privileges ON object FROM user;
```