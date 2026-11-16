from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import joblib
from pathlib import Path

# Create your views here.

def ajax_data(request):
    BASE_DIR = Path(__file__).resolve().parent.parent
    model = joblib.load(BASE_DIR/'model.joblib')
    data = request.POST.get('data','40,11.73,7.22')
    result=list(map(float,data.split(',')))
    result2=model.predict([result])
    print("데이터:",data)
    # 머신러닝 예측 결과
    context = {
        'result':result, 'result2':f"{result2[0]:.2f}"
    }
    return JsonResponse(context)




# 
def index(request):
    data=request.POST.get('data','40,11.73,7.22')
    context={'result':data, 'result2':870.41}
    return render(request, 'index.html',context)
