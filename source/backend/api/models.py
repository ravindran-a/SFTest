from django.db import models
from django.contrib.auth import get_user_model


# Create your models here.
class Folder(models.Model):
    folder_name = models.CharField("Folder Name", max_length=255)
    user = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
        db_constraint=False,
    )


class TodoList(models.Model):
    description = models.TextField("Description")
    folder = models.ForeignKey(
        "Folder",
        on_delete=models.CASCADE,
        default=None,
        blank=True,
        null=True,
        db_constraint=False,
    )
    user = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
        db_constraint=False,
    )
