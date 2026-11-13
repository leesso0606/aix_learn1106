from django.db import models
from board.models import Board

# Create your models here.
class Screen(models.Model):
    board= models.ForeignKey(Board, on_delete=models.CASCADE)
    director=models.CharField(max_length=1000)
    actor=models.CharField(max_length=1000)
    actress=models.CharField(max_length=1000)

    def __str__(self):
        return f"{self.board.bno},{self.board.btitle},{self.director},{self.actor},{self.actress}"    