from django.shortcuts import render

# Create your views here.
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import permissions, status, viewsets
from rest_framework.generics import CreateAPIView
from . import serializers
from .models import Folder, TodoList

from django.contrib.auth import get_user_model


class CreateUserView(CreateAPIView):
    model = get_user_model()
    permission_classes = [permissions.AllowAny]
    serializer_class = serializers.UserSerializer


class Logout(APIView):
    def get(self, request, format=None):
        request.user.auth_token.delete()
        return Response(
            {"message": "Logged out successfully"}, status=status.HTTP_200_OK
        )


class TodoListsViewSet(viewsets.ViewSet):
    permission_classes = [permissions.IsAuthenticated]

    def list(self, request):
        """
        Return a list of all Todos.
        """
        user = request.user
        todo_dataset = TodoList.objects.filter(user=user)
        todo_data = serializers.TodoListsSerializer(todo_dataset, many=True)
        return Response(todo_data.data)

    def create(self, request):
        user = request.user
        description = request.POST.get("description", None)
        todos = TodoList.objects.create(description=description, user=user)
        todos.save()
        todos_data = serializers.TodoListsSerializer(todos)
        return Response(
            {"data": todos_data.data, "message": "Added successfully"},
            status=status.HTTP_200_OK,
        )

    def destroy(self, request, pk=None):
        user = request.user
        if pk is None:
            return Response(
                {"message": "Primary key not found"}, status=status.HTTP_400_BAD_REQUEST
            )
        try:
            todo = TodoList.objects.get(pk=pk, user=user)
            todo.delete()
            return Response(
                {"message": "Deleted Sucessfully"},
                status=status.HTTP_200_OK,
            )
        except:
            return Response(
                {"message": "Something went wrong"},
                status=status.HTTP_400_BAD_REQUEST,
            )

    def update(self, request, pk=None):
        user = request.user
        description = request.POST.get("description", None)
        if pk is None:
            return Response(
                {"message": "Primary key not found"}, status=status.HTTP_400_BAD_REQUEST
            )
        try:
            todos = TodoList.objects.get(pk=pk, user=user)
            todos.description = description
            todos.save()
            todos_data = serializers.TodoListsSerializer(todos)
            return Response(
                {"message": "Updated Sucessfully", "data": todos_data.data},
                status=status.HTTP_200_OK,
            )
        except:
            return Response(
                {"message": "Something went wrong"},
                status=status.HTTP_400_BAD_REQUEST,
            )
