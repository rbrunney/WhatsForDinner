# Generated by Django 4.1 on 2022-08-08 15:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chatcomponents', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='person',
            old_name='userId',
            new_name='userID',
        ),
        migrations.AddField(
            model_name='channels',
            name='groupName',
            field=models.CharField(default=1, max_length=2048),
            preserve_default=False,
        ),
    ]
