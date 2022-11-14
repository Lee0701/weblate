# Generated by Django 4.1.3 on 2022-11-14 10:23

from django.db import migrations


def create_index(apps, schema_editor):
    if schema_editor.connection.vendor != "postgresql":
        return
    # Install btree_gin for gin btree search and index
    cur = schema_editor.connection.cursor()
    cur.execute("SELECT * FROM pg_extension WHERE extname = 'btree_gin'")
    if not cur.fetchone():
        schema_editor.execute("CREATE EXTENSION IF NOT EXISTS btree_gin")
    schema_editor.execute("DROP INDEX memory_source_trgm")
    schema_editor.execute(
        "CREATE INDEX memory_source_trgm_tmp ON memory_memory USING GIN "
        "(source gin_trgm_ops, target_language_id, source_language_id)"
    )


class Migration(migrations.Migration):

    dependencies = [
        ("memory", "0012_remove_blank"),
    ]

    operations = [
        migrations.RunPython(
            create_index, migrations.RunPython.noop, elidable=False, atomic=False
        )
    ]
