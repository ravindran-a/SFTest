from django.contrib import admin
from .models import Folder
from .models import TodoList

# Register your models here.
admin.site.register(Folder)
admin.site.register(TodoList)
