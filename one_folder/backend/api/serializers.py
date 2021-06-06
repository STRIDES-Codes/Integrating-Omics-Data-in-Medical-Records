from django.core.validators import validate_email
from django.db.models import fields
from rest_framework import serializers
from ..models import *
from django.utils.translation import gettext_lazy as _

class UserSerializer (serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"
        extra_kwargs = {
            'password':{"write_only":True}
        }
        
    def create(self, validated_data):
        account = User(
            email = self.validated_data['email'],
            username = self.validated_data['username'],
            function = self.validated_data['function'],
            first_name = self.validated_data['first_name'],
            last_name = self.validated_data['last_name'],
            is_active= validated_data['is_active'],
            cin = validated_data['cin'],
            phone = validated_data['phone']
        )
        password = self.validated_data['password']
        account.set_password(password)
        account.save()
        return account

class UserRegisterSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style = {"input_type":"password"},write_only=True)
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email', 'username','national_id','phone', 'function','password','password2']
    def save(self):
        account = User(
            email = self.validated_data['email'],
            username = self.validated_data['username'],
            national_id=self.validated_data['national_id'],
            first_name=self.validated_data['first_name'],
            last_name=self.validated_data['last_name'],
            phone=self.validated_data['phone'],
            function = self.validated_data['function']
        )
        password = self.validated_data['password']
        password2 = self.validated_data['password2']
        if password == password2:
            account.set_password(password)
            account.save()
            return account
        else:
            raise serializers.ValidationError({"password":_("Password doesn't matche")})

class DoctorSerializer (serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = "__all__"

class ResearcherSerializer (serializers.ModelSerializer):
    class Meta:
        model = Researcher
        fields = "__all__"

class PatientSerializer (serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = "__all__"

class StatusSerializer (serializers.ModelSerializer):
    class Meta:
        model = Status
        fields = "__all__"

class GeneExpressionSerializer (serializers.ModelSerializer):
    class Meta:
        model = GeneExpression
        fields = "__all__"

class Analysis_serializer (serializers.Serializer):
    patient = serializers.CharField()
    class Meta:
        fields = ['patient']

class SequenceSerializer (serializers.ModelSerializer):
    content = serializers.CharField()
    class Meta:
        model = Sequence
        fields = ['id','patient','content', 'direction']