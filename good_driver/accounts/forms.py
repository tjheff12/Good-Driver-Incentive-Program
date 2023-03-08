from django import forms
from . import models

def get_all_sponsors():
    all_sponsors = models.Sponsor.objects.filter().values('name')
    
    all_sponsors_list = [(entry['name'],entry['name']) for entry in all_sponsors]
    
    return all_sponsors_list


class SponsorForm(forms.Form):
    

    sponsor_name = forms.ChoiceField(label='Sponsor List', choices=[])
    
    def __init__(self,*args,**kwargs):
        super(SponsorForm,self).__init__(*args,**kwargs)
        self.fields['sponsor_name'].choices = get_all_sponsors

    class Meta:
        model = models.Sponsor
        
        #widget = {
            #'Sponsors': forms.Select(choices=models.Sponsor.name, attrs={'class':'sponsorForm'}),
        #}

class getDriverEmail(forms.Form):
    email = forms.CharField(label = "Driver Email", required=False)


class getDriverInfo(forms.Form):
    first_name = forms.CharField(label = 'first_name', required=False)
    last_name = forms.CharField(label = 'last_name', required=False)
    street_address = forms.CharField(label = 'street_address', required=False)
    city = forms.CharField(label = 'city', required=False)
    zip_code = forms.CharField(label = 'zip_code', required=False)
    phone_number = forms.CharField(label = 'phone_number', required=False)