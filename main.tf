module "gke" {
    source = "./module/gke"

    //TODO set some vars here
}

module "nginx_svc" {
    source = "./module/app"

    //TODO set some vars here
}