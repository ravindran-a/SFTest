from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import TodoList


class TodoListsSerializer(serializers.ModelSerializer):
    class Meta:
        model = TodoList
        fields = ["pk", "description"]


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    def create(self, validated_data):
        user = get_user_model().objects.create_user(
            username=validated_data["username"],
            password=validated_data["password"],
        )

        return user

    class Meta:
        model = get_user_model()
        fields = (
            "id",
            "username",
            "password",
        )
