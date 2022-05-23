# **실행계획(Execution Plan)**

<br>

* ### Nested Loop 방식의 조인은 DEPT 테이블에서 먼저 데이터를 찾고 그다음 EMP 테이블을 찾는 것을 의미한다.

<br>

* ### SQL 실행 흐름도

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/2a2666b7-6567-4fd1-b0e1-13b8ccfdfb4e/image.png)

<br>

* ### 위의 SQL 실행 흐름도를 보면 INDEX를 검색하고 ROWID를 사용해서 DEPT 테이블을 조회한다.

<br>

* ### 이때 먼저 조회되는 테이블을 Outer Table이라고 하고, 그 다음에 조회되는 테이블을 Inner Table이라고 한다.