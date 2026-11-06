# pip install scikit-learn scipy scikit-image 또는 python -m pip install scikit-learn scipy scikit-image 설치
#  pip install numpy 또는 python -m pip install numpy
# pip install scipy or python -m pip install scipy
# python -m pip install ipykernel jupyter



from sklearn import svm, metrics

# 항상 학습 데이터는 2차원 배열 형태.
# 1. 데이터 준비 : 학습데이터와 테스트데이터 분리 8:2
data=[[0,0],[0,1],[1,0],[1,1]] #문제
label=[0,1,1,0]                 #답

# 테스트 데이터
test_data= [[0,0],[1,0]]
test_label=[0,1]

# 2.데이터 학습
clf=svm.SVC()       #알고리즘 선택
clf.fit(data, label)   #학습

# 3.데이터 예측
result=clf.predict(test_data)   # 테스트 데이터를 가지고 예측실행
print("예측결과:", result)

# 4. 정답율
score=metrics.accuracy_score(test_label, result)
# score=clf.score(test_data, test_label)
print("정답율:", score)