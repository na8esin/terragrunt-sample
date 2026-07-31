module "ecs_autoscaling" {
  source = "../../../module/ecs_autoscaling"

  app_name                        = "watanabe"
  env                             = "dev"
  min_capacity                     = 1
  max_capacity                     = 1
  enable_night_weekend_shutdown    = true
}
