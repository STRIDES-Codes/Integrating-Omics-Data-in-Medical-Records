from django.db import models
from django.db import models
from django.contrib.auth.models import AbstractUser, PermissionsMixin
from django.db.models.fields import TextField
from django.db.models.fields.related import ForeignKey
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token

class User(AbstractUser):
    email = models.EmailField(_("Email"), max_length=254, unique=True, null= False)
    first_name = models.CharField(_("First Name"), max_length=50, null= False)
    last_name = models.CharField(_("Last Name"), max_length=50, null=False)
    function = models.CharField(_("Function"),choices=(("Doctor","Doctor"),("Researcher","Researcher"),("Admin","Admin")), max_length=50, null= False)
    username = models.CharField(_("Username"),unique=True, max_length=50, null=False)
    national_id = models.CharField(_("CIN"),unique=True, max_length=50, null= False)
    phone = models.CharField(_("Phone number"),unique=True, max_length=50,null= False)
    is_active = models.BooleanField(_("Active ?"),default=False)
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS=['first_name','last_name',"function", "national_id",'phone','username']
class Doctor (models.Model):
    user = models.OneToOneField(User, verbose_name=_("Account"), on_delete=models.CASCADE)
    id_pro = models.CharField(_("Professional ID"), max_length=50, null=True)

class Researcher(models.Model):
    user = models.OneToOneField(User, verbose_name=_("Account"), on_delete=models.CASCADE)
    affiliation = models.CharField(_("Affiliation"), max_length=50)
