from django.shortcuts import render
from django.http import JsonResponse
import joblib
from pathlib import Path

# Create your views here.
BASE_DIR = Path(__file__).resolve().parent.parent
model = joblib.load(BASE_DIR/'model.joblib')

# 선생님과 함께
def ajax_data(request):
    data = request.POST.get('data','40,11.73,7.22')

    # 파일전환
    in_data = data
    in_data = in_data.split(',')
    result = list(map(float,in_data))

    # 예측
    print('입력데이터 : ',result)
    result = model.predict([result])
    print(f'예측무게 : {result[0]:.2f} g')

    # 예측파일 전달
    context = {
        'resule_data':f'{result[0]:.2f}', 'result':'success'
    }
    return JsonResponse(context)


#  내가한것
# def ajax_data(request):
#     BASE_DIR = Path(__file__).resolve().parent.parent
#     model = joblib.load(BASE_DIR/'model.joblib')
#     data = request.POST.get('data','40,11.73,7.22')
#     result=list(map(float,data.split(',')))
#     result2=model.predict([result])
#     print("데이터:",data)
#     # 머신러닝 예측 결과
#     context = {
#         'result':result, 'result2':f"{result2[0]:.2f}"
#     }
#     return JsonResponse(context)




# 메인페이지
def index(request):
    # BASE_DIR = Path(__file__).resolve().parent.parent
    # model = joblib.load(BASE_DIR/'model.joblib')
    # print("베이스:",BASE_DIR)
    # in_data = '40,11.73,7.22'
    # in_data = in_data.split(',')
    # result = list(map(float,in_data))

    # # 예측
    # print('입력데이터 : ',result)
    # result = model.predict([result])
    # print(f'예측무게 : {result[0]:.2f} g')
    
    return render(request, 'index.html')
