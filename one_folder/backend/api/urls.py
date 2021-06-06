from django.urls.conf import path
from .views import *
from django.views.decorators.csrf import csrf_exempt

urlpatterns = [
    #authentication
    path('auth/', csrf_exempt(CustomAuthToken.as_view())),
    path('logout/',logout),
    # path('analyse/',analyse),
    #register
    path('register/',registration_view,name = 'register'),
    path("users/",users_list,name= 'users'),
    path("users/<int:pk>",user_detail,name= 'users'),
    path("doctors/",medecins_list,name= 'doctors'),
    path("doctors/<int:pk>",doctor_detail,name= 'doctors'),
    #chercheur get put post and delete
    path("researchers/",Researcher_detail,name= 'researchers'),
    path("researchers/<int:pk>",Researcher_detail,name= 'researchers'),
    path('patients/', patients_detail, name = 'patients'),
    path("patients/<int:pk>", patients_detail, name="patients")
]