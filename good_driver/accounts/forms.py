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