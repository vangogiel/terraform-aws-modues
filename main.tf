module "vpc-subnets-ig" {
    source      = "./vpc-subnets-ig"
    environment = var.environment
    region      = var.region
}

module "bastion-multuple-az" {
    source          = "./bastion-multiple-az"
    key_name        = var.key_name
    public_key      = var.public_key
    vpc_id          = module.vpc-subnets-ig.vpc_id.id
    public_subnets  = module.vpc-subnets-ig.public_subnets
}

module "rds-single-az" {
    source                          = "./rds-single-az"
    vpc_id                          = module.vpc-subnets-ig.vpc_id.id
    additional_db_security_group    = module.bastion-multuple-az.bastion-host-security-group
    private_subnets                 = module.vpc-subnets-ig.private_subnets
    db_username                     = var.db_username
    db_password                     = var.db_password
    db_port                         = var.db_port
    db_allocated_storage            = var.db_allocated_storage
    db_engine                       = var.db_engine
    db_engine_version               = var.db_engine_version
    db_instance_class               = var.db_instance_class
}
