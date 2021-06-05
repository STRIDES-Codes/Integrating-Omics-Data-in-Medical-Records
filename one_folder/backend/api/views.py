from django.views.decorators.csrf import csrf_exempt
from rest_framework.utils import serializer_helpers
from .serializers import *
from django.contrib.auth import logout as django_logout
from ..models import *
from rest_framework.views import APIView
from rest_framework.decorators import action, api_view, permission_classes,renderer_classes,parser_classes
from rest_framework.response import Response
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from django.http.response import Http404, HttpResponse
from rest_framework import status
from django.utils.translation import gettext_lazy as _
from rest_framework.parsers import FormParser, MultiPartParser
import datetime
import subprocess
import os
import csv
from pathlib import Path
from rest_framework.renderers import JSONRenderer, TemplateHTMLRenderer

for user in User.objects.all():
    Token.objects.get_or_create(user=user)

class CustomAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        doctor_user = Doctor.objects.filter(user = user).first()
        if doctor_user!=None:
            doctor_id = doctor_user.id
        else:
            doctor_id = ''
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            "doctor_id":doctor_id,
            'email': user.email,
            'name':f"{user.first_name} {user.last_name}",
            "function":user.function
        })

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def logout(request):
    if request.method=='POST':
        django_logout(request)
    return Response(status=status.HTTP_200_OK)

@api_view(['GET', 'POST'])
@permission_classes((IsAuthenticated,))
def users_list(request):
    if request.method == 'GET':
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)
    elif request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes((IsAuthenticated,))
def user_detail(request, pk):
    try:
        user = User.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    if request.method == 'GET':
        serializer = UserSerializer(user)
        return Response(serializer.data)
    elif request.method == 'PUT':
        serializer = UserSerializer(user, data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['POST',])
def registration_view(request):
    if request.method == 'POST':
        serializer = UserRegisterSerializer(data = request.data)
        data = {}
        if serializer.is_valid():
            account = serializer.save()
            data ['response'] = "successfully registred"
            data['email'] = account.email
            data['username'] = account.username
            # token = Token.objects.get(user = account)
            # data['token'] = token
            data['id']=account.id
        else:
            data = serializer.errors
        return Response(data)

@api_view(['GET', 'POST'])
# @permission_classes((IsAuthenticated,))
def Researcher_list(request):
    if request.method == 'GET':
        users = Researcher.objects.all()
        serializer = ResearcherSerializer(users, many=True)
        data = []
        for i in serializer.data:
            user = User.objects.get(id = int(i['user']))
            i['username']=user.username
            i['function']=user.function
            i['email']=user.email
            i['national_id']=user.national_id
            i['phone']=user.phone
            i['first_name']=user.first_name
            i['last_name']=user.last_name
            data.append (i)
        return Response(data)
    elif request.method == 'POST':
        serializer = ResearcherSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#Put and delete Researcher
@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes((IsAuthenticated,))
def Researcher_detail(request, pk):
   
    try:
        user = Researcher.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = ResearcherSerializer(user)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = ResearcherSerializer(user, data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

#Doctor
@api_view(['GET', 'POST'])
# @permission_classes((IsAuthenticated,))
def medecins_list(request):
    if request.method == 'GET':
        users = Doctor.objects.all()
        serializer = DoctorSerializer(users, many=True)
        data = []
        for i in serializer.data:
            user = User.objects.get(id = int(i['user']))
            i['username']=user.username
            i['function']=user.function
            i['email']=user.email
            i['cin']=user.cin
            i['phone']=user.phone
            i['first_name']=user.first_name
            i['is_active']=user.is_active
            i['last_name']=user.last_name
            i['password']=user.password
            data.append (i)
        return Response(data)
    elif request.method == 'POST':
        serializer = DoctorSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes((IsAuthenticated,))
def doctor_detail(request, pk):
   
    try:
        user = Doctor.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = DoctorSerializer(user)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = DoctorSerializer(user, data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

#Patients
@api_view(['GET', 'POST'])
@permission_classes((IsAuthenticated,))
def Patients_list(request):
    if request.method == 'GET':
        users = Patient.objects.all()
        serializer = PatientSerializer(users, many=True)
        data = []
        for i in serializer.data:
            medecin = Doctor.objects.get(id = int(i['doctor']))
            sequnce = Sequence.objects.filter(patient = int(i['id'])).order_by('-id')
            if len(sequnce) >0:
                sequnce = sequnce[0]
            else:
                sequnce = None
            statuses = Status.objects.filter(patient = int(i['id'])).order_by('-id')
            statuses = list (statuses)
            if len (statuses) > 0:
                
                last_declared = statuses[0]
            else:
                onset_status = None
                last_declared = None
            i['doctor_username']=medecin.user.username
            i['doctor_name']=f"{medecin.user.first_name} {medecin.user.last_name}"
            i["doctor_id"]= medecin.id_pro
            i["doctor_phone"] = medecin.user.phone
            i['doctor_email']=medecin.user.email
            if sequnce:
                i['last_sequence'] = sequnce.id
                i['last_sequence_date'] = sequnce.add_date
            else:
                i['last_sequence'] = 'None'
            
            if last_declared:
                i['last_status_id'] = last_declared.id
                i['last_status'] = last_declared.status
                i['last_check_date'] = last_declared.date
                i['last_check_infos'] = last_declared.infos
            else:
                i['last_status'] = 'None'
            data.append (i)
        return Response(serializer.data)
    elif request.method == 'POST':
        serializer = PatientSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes((IsAuthenticated,))
def patients_detail(request, pk):
   
    try:
        user = Patient.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = PatientSerializer(user)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = PatientSerializer(user, data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((TemplateHTMLRenderer, JSONRenderer))
@parser_classes((MultiPartParser, FormParser))
@renderer_classes((JSONRenderer))
def Virus_view(request):
    if request.method == 'POST':
    # def post(self, request, *args, **kwargs):
        file_serializer = SequenceSerializer(data=request.data)
        if file_serializer.is_valid():
            patient = Patient.objects.get(id = request.data['patient'])
            add_date = datetime.datetime.now()
            add_date=add_date.strftime("%m-%d-%Y_%H:%M:%S")
            # Path(f"Sequence/{patient.cin}/virus").mkdir(parents=True, exist_ok=True)
            with open(f"tmp/{patient.id}/{add_date}_{request.data['direction']}.fastq", "w") as f:
                f.write(request.data['content'])
            seq = Sequence(patient=patient, sequnce=f"tmp/{patient.id}/{add_date}_{request.data['direction']}.fastq",direction = request.data['direction'])
            seq.save()
            os.remove(f"tmp/{patient.id}/{add_date}_{request.data['direction']}.fastq")
            # file_serializer.save()
            if request.accepted_renderer.format == 'html':
                return HttpResponse('')
            return Response(file_serializer.data, status=status.HTTP_201_CREATED)
        return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    if request.method=='GET':
        virus = Sequence.objects.all()
        serializer = SequenceSerializer(virus)
        return Response(serializer.data)
