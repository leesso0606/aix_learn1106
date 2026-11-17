from django.shortcuts import render
from django.http import JsonResponse
from pathlib import Path
import os
import joblib
import numpy as np
from scipy.special import softmax

# Create your views here.
# 모델 불러오기
BASE_DIR = Path(__file__).resolve().parent.parent
model_ex = joblib.load(BASE_DIR/"model_ex.joblib")

# ajax
def ajax_data(request):
    global model_ex
    # html에서 들어온 데이터
    data = request.POST.get('data','290.0, 26.3,31.2,12.48,4.3056')

    # 데이터 변환
    in_data = data
    in_data = in_data.split(',')
    in_data = list(map(float, in_data))

    # 모델에 넣어 예상 생선, 확률 출력
    result = model_ex.predict([in_data])                #예측 생선종류
    result2 = model_ex.predict_proba([in_data])         #예측 생선확률

    # 모든 종류의 전체확률
    decisions = model_ex.decision_function([in_data])
    soft1 = softmax(decisions,axis=1)
    result_all = np.round(soft1,decimals=3)[0]          
    if result == 'Bream':
        result2 = result_all[0]
    elif result == 'Parkki':
        result2 = result_all[1]    
    elif result == 'Perch':
        result2 = result_all[2]    
    elif result == 'Pike':
        result2 = result_all[3]    
    elif result == 'Roach':
        result2 = result_all[4]    
    elif result == 'Smelt':
        result2 = result_all[5]    
    elif result == 'Whitefish':
        result2 = result_all[6]    

    print(f'예측 생선 : {result[0]} (예측확률 : {result2}) ')
    print('전체확률 : ',result_all)

    # html로 전달
    # NumPy 배열 → tolist() → Python 리스트→ JsonResponse → JavaScript 배열 → 그래프 출력/ 
    # .tolist()로 json으로 전달하기 편한 상태로 변환, 배열은 그대로
    context = {'result':result[0], 'result2':result2, 'result_all':result_all.tolist()}

    return JsonResponse(context)






# 메인페이지
def index(request):
    return render(request, 'index.html')