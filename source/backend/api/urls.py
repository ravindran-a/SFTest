from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken.views import obtain_auth_token

router = DefaultRouter()
router.register("todo-lists", views.TodoListsViewSet, basename="TodoLists")

urlpatterns = [
    path("", include(router.urls)),
    path("login/", obtain_auth_token),
    path("register/", views.CreateUserView.as_view()),
    path("logout/", views.Logout.as_view()),
]