[
    {
        "essential": true,
        "memory": 1024,
        "name": "ghost",
        "cpu": 256,
        "image": "${REPOSITORY_URL}:latest",
        "environment": [
            {
                "name": "database__client",
                "value": "mysql"
            },
            {
                "name": "database__connection__host",
                "value": "${DB_URL}"
            },
            {
                "name": "database__connection__user",
                "value": "admin"
            },
            {
                "name": "database__connection__password",
                "value": "foobarbaz"
            },
            {
                "name": "database__connection__database",
                "value": "mydb"
            },
        ],
        "portMappings": [
            {
                "containerPort": 2368,
                "hostPort": 2368
            }
        ],
        "mountPoints": [
            {
                "containerPath": "/var/lib/ghost/content",
                "sourceVolume": "efs-storage"
            }
        ]
    }
]