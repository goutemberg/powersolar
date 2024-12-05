

from django.urls import path
from solar.views import index

app_name = "solar"

urlpatterns = [
    path('', index, name='index'),
]

