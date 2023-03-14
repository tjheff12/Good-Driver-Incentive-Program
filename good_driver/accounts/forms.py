from django import forms
from . import models

def get_all_sponsors():
    all_sponsors = models.Sponsor.objects.filter().values('name')
    
    all_sponsors_list = [(entry['name'],entry['name']) for entry in all_sponsors]
    
    return all_sponsors_list


def get_all_drivers_with_sponsor(sponsor_id):
    print("getting drivers for sponsor " + str(sponsor_id))
    driver_query = models.DriverSponsor.objects.select_related('user').filter(sponsor=sponsor_id)#.values()
    for x in driver_query:
        print(x.user.first_name)

    all_drivers_list =[(entry.user.first_name + " " + entry.user.last_name, entry.user.first_name + " " + entry.user.last_name) for entry in driver_query]
    print(all_drivers_list)
    return all_drivers_list


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


class allDriversForSponsor(forms.Form):
    
    #test = forms.CharField(label="test", max_length=10)

    def __init__(self,*args,**kwargs):
        
        #self.sponsor_id = args[0]
        for x in kwargs:
            print(x)
        #print(get_all_drivers_with_sponsor(args[0]))
        super(allDriversForSponsor,self).__init__(*args,**kwargs)
        self.fields['DRIVERS'] = get_all_drivers_with_sponsor(args[0])
        
        #self.fields['driver_option'].queryset = models.DriverSponsor.objects.select_related('user').filter(sponsor=args[0])
        
    DRIVERS = []
    driver_option = forms.ChoiceField(label='Driver', choices=DRIVERS)

    
class getDriverEmail(forms.Form):
    email = forms.CharField(label = "Driver Email", required=False)


class getDriverInfo(forms.Form):
    first_name = forms.CharField(label = 'first_name', required=False)
    last_name = forms.CharField(label = 'last_name', required=False)
    street_address = forms.CharField(label = 'street_address', required=False)
    city = forms.CharField(label = 'city', required=False)
    zip_code = forms.CharField(label = 'zip_code', required=False)
    phone_number = forms.CharField(label = 'phone_number', required=False)
