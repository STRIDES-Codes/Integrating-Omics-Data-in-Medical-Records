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
import datetime

now = datetime.datetime.now()

class User(AbstractUser):
    email = models.EmailField(_("Email"), max_length=254, unique=True, null= False)
    first_name = models.CharField(_("First Name"), max_length=50, null= False)
    last_name = models.CharField(_("Last Name"), max_length=50, null=False)
    function = models.CharField(_("Function"),choices=(("Doctor","Doctor"),("Researcher","Researcher"),("Admin","Admin")), max_length=50, null= False)
    username = models.CharField(_("Username"),unique=True, max_length=50, null=False)
    national_id = models.CharField(_("National ID"),unique=True, max_length=50, null= False)
    phone = models.CharField(_("Phone number"),unique=True, max_length=50,null= False)
    is_active = models.BooleanField(_("Active ?"),default=True)
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS=['first_name','last_name',"function", "national_id",'phone','username']

class Doctor (models.Model):
    user = models.OneToOneField(User, verbose_name=_("Account"), on_delete=models.CASCADE)
    adding_date = models.DateField(_("Adding date"), auto_now=True, auto_now_add=False)
    id_pro = models.CharField(_("Professional ID"), max_length=50, null=True)

class Researcher(models.Model):
    user = models.OneToOneField(User, verbose_name=_("Account"), on_delete=models.CASCADE)
    adding_date = models.DateField(_("Adding date"), auto_now=True, auto_now_add=False)
    affiliation = models.CharField(_("Affiliation"), max_length=50)
def generate_mrn():
    import random 
    while True:
        mrn = random.randint(0,1000000000)
        if Patient.objects.filter(mrn =mrn).count()==0:
            break
    return mrn
class Patient(models.Model):
    mrn = models.IntegerField(_("MRN"), default=generate_mrn)
    doctor = models.ForeignKey(Doctor, verbose_name=_("Doctor"), on_delete=models.CASCADE)
    national_id = models.CharField(_("National id"),unique=True, max_length=50)
    city = models.CharField(_("city"), max_length=50, null=False)
    nationality = models.CharField(_("Nationality"), max_length=50, null=False)
    gender = models.CharField(_("Gender"),choices=(("Male","Male"),("Female","Female"),("Other","Other"),("Unknown","Unknown")), max_length=50)
    birthdate = models.DateField(_("Birthdate"), auto_now=False, auto_now_add=False,null=False)
    first_name = models.CharField(_("Firtst Name"),null=False, max_length=50)
    last_name = models.CharField(_("Last Name"),null= False, max_length=50)
    onset_date = models.DateField(_("Onset Date"), auto_now=True, auto_now_add=False)
    phone = models.CharField(_("Phone"),unique=True, max_length=50)
    disease = models.CharField(_("Disease"), max_length=50, null=False)
    def age (self):
        return now - self.birtdate

class Status(models.Model):
    patient = models.ForeignKey(Patient, verbose_name=_("Patient"), on_delete=models.CASCADE)
    date = models.DateField(_("Date"), auto_now=True, auto_now_add=False)
    status = models.CharField(_("Status"),null=False, max_length=50)
    note = models.TextField(_("Additional informations"))

class Comments(models.Model):
    user = models.ForeignKey(User, verbose_name=_("User"), on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, verbose_name=_(""), on_delete=models.CASCADE)
    date = models.DateField(_("Date"), auto_now=True, auto_now_add=False)
    comment = models.TextField(_("Comment"))

def upload_to (instance, filename):
    return f"Sequences/{instance.patient.id}/{instance.add_date}_{instance.direction}.fastq"
class Sequence(models.Model):
    patient = models.ForeignKey(Patient, verbose_name=_("Patient"), on_delete=models.CASCADE)
    add_date = models.DateTimeField(_("Submission date"), auto_now=True, auto_now_add=False)
    direction = models.CharField(_("Direction"), choices=(('Forward',"Forward"),("Reverse","Reverse"),("Single","Single")), max_length=50)
    sequnce = models.FileField(_("Sequence"), upload_to=upload_to, max_length=100,blank=True)

class GeneExpression(models.Model):
    gene = models.CharField(_("Gene"),null = False, max_length=50)
    expression = models.DecimalField(_("Expression level"), max_digits=10, decimal_places=3)
    sequence = models.ForeignKey(Sequence, verbose_name=_("Sequence"), on_delete=models.CASCADE)
    date = models.DateField(_("Adding date"), auto_now=False, auto_now_add=False)

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)