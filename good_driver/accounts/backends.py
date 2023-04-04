
from . import models

class CustomAuthBackend(object):
	
 
	def authenticate( username=None, password=None):
		import hashlib
		""" Authenticate a user based on email address as the user name. """
		
		password_hash = hashlib.md5(password.encode()).hexdigest()
		try:
			user = models.Users.objects.get(email=username)
			
			if user.password == password_hash:
				return user
		except models.Users.DoesNotExist:
				return None
		
	def prehashed_auth(username=None, password=None):
		try:
			user = models.Users.objects.get(email=username)
			
			if user.password == password:
				return user
		except models.Users.DoesNotExist:
				return None

	def get_user(self, user_id):
		""" Get a User object from the user_id. """
		try:
			return models.Users.objects.get(pk=user_id)
		except models.Users.DoesNotExist:
			return None