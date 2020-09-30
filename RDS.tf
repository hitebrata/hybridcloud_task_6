// AWS prvider details

provider "aws" {
   profile    = var.profile
   region     = var.aws_region
}
resource "aws_db_subnet_group" "dbsubnet" {
      name                 = "main"
      subnet_ids           = ["SUBNET_1", "SUBNET_2"]
}

resource "aws_db_instance" "sqldb" {
        allocated_storage                   = var.allocated_storage
        storage_type                        = var.storage_type
        identifier                          = var.identifier
        engine                              = var.engine
        engine_version                      = var.engine_version
        instance_class                      = var.instance_class
        name                                = var.DBname
        username                            = var.username
        password                            = var.password
        port                                = var.port
        db_subnet_group_name                = aws_db_subnet_group.dbsubnet.name
        auto_minor_version_upgrade          = true
        iam_database_authentication_enabled = true
        parameter_group_name                = var.parameter_group_name
        skip_final_snapshot                 = var.skip_final_snapshot
        publicly_accessible                 = var.publicly_accessible
        final_snapshot_identifier           = var.skip_final_snapshot
tags = {
    Name  = "wordpress_mysql_db"
  }
}
output "ip" {
   value = aws_db_instance.sqldb.address

  }
