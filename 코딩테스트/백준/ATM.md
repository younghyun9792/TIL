```py
import sys
N=int(sys.stdin.readline()) # 사람의 수
people_time = list(map(int,sys.stdin.readline().split())) # 사람들의 걸리는 시간
people_time.sort() # 시간이 적은 사람이 먼저 인출해야 뒷사람이 더 빨리 뽑음. 즉, 오름차순으로 정렬하면 최소값이 나옴
result=0 # 시간
temp=0 # 누적합
for i in range(N):
    temp+=people_time[i]
    result+=temp
print(result) # 출력
```