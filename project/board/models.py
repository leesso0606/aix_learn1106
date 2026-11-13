from django.db import models

# Create your models here.
class Board(models.Model):
    bno=models.AutoField(primary_key=True)
    btitle=models.CharField(max_length=1000)
    bgenre=models.CharField(max_length=1000,\
            choices=[('액션', '액션'),('드라마', '드라마'),('스릴러', '스릴러'),('코믹', '코믹'),])
    bcontent=models.TextField()
    bdate = models.DateTimeField(auto_now=True,blank=True)

    def __str__(self):
        return f"{self.bno},{self.btitle},{self.bgenre}"