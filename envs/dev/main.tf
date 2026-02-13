module "network" {
  source = "../../modules/network"

  name               = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  create_nat_gateway = true
  tags               = local.standard_tags
}

module "k8s" {
  source = "../../modules/k8s"

  name                   = "${local.name_prefix}-eks"
  vpc_id                 = module.network.vpc_id
  private_subnet_ids     = module.network.private_subnet_ids
  endpoint_public_access = var.endpoint_public_access
  node_desired_size      = 2
  node_min_size          = 1
  node_max_size          = 4
  tags                   = local.standard_tags
}

module "db" {
  source = "../../modules/db"

  name                = local.name_prefix
  vpc_id              = module.network.vpc_id
  subnet_ids          = module.network.db_subnet_ids
  allowed_cidr_blocks = module.network.private_subnet_cidrs
  db_name             = "platform"
  instance_class      = var.db_instance_class
  backup_retention_days = 14
  deletion_protection = true
  multi_az            = var.db_multi_az
  tags                = local.standard_tags
}

module "observability" {
  source = "../../modules/observability"

  name          = local.name_prefix
  alert_email   = var.alert_email
  tags          = local.standard_tags
  log_retention_days = 30
}
