/*resource "google_storage_bucket" "test" {
  name          = "bullit-test-bucketasd"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}*/

/*resource "google_compute_instance" "default" {
  name         = "my-instance2"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
  }
 } */

##Cloud run
/*resource "google_cloud_run_v2_service" "default" {
  name     = var.cloud-run1
  location = "us-central1"

  template {
    containers {
      image = var.test-image
    }
  }
}


resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}*/

##cloud functions
/*resource "google_storage_bucket" "bucket" {
  name     = "test-bucketazedfqa"
  location = "us-central1"
  force_destroy = false 
}

resource "google_storage_bucket_object" "object2" {
  name   = "testcode"
  bucket = google_storage_bucket.bucket.name
  source = "function-source.zip"
}

resource "google_cloudfunctions2_function" "function" {
  name        = "function-test"
  location	  = "us-central1"
  description = "My function"
  
  build_config {
    runtime = "go121"
    entry_point = "SimExtract"  # Set the entry point 
    environment_variables = {
        DATABASE_URL = "postgres://postgres:dhOnoPu5HuwznnvV@db.nordcagpfxpthkwjwtvs.supabase.co:6543/postgres"
    }
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object2.name
      }
    }
  }
    service_config {
    max_instance_count  = 3
    min_instance_count = 1
    available_memory    = "4Gi"
    timeout_seconds     = 60
    max_instance_request_concurrency = 80
    available_cpu = "4"
    ingress_settings = "ALLOW_ALL"
    all_traffic_on_latest_revision = true
    service_account_email = var.serviceaccount
  }

  event_trigger {
    trigger_region = "us-central1"
    event_type = "google.cloud.storage.object.v1.finalized"
    retry_policy = "RETRY_POLICY_RETRY"
    event_filters {
      attribute = "bucket"
      value = google_storage_bucket.bucket.name
    }
  }
}*/

## CloudSQL - Postgres
/*resource "google_sql_database" "database" {
  name     = "postgres-test"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "my-test-instance"
  region           = "us-central1"
  database_version = "POSTGRES_15"
  deletion_protection = "true"
  settings {
    tier = "db-perf-optimized-N-4"
	edition = "ENTERPRISE_PLUS"
	availability_type = "REGIONAL"
	disk_type = "PD_SSD"
	disk_size = "250"
	ip_configuration {
      ipv4_enabled  = false
      private_network = var.network
      enable_private_path_for_google_cloud_services = true
	  }
	backup_configuration {
	  enabled = "true"
	  location = "us"
	  point_in_time_recovery_enabled = "true"
          transaction_log_retention_days = "14"
	  }	
  }

}


resource "google_sql_user" "users" {
  name     = var.admin-user
  instance = google_sql_database_instance.instance.name
  password = var.admin-password
}*/

##Secret Manager 

/*resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "TEST_SECRET"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = var.secret-data
}*/


##Testing depends_on functionality for cloudsql postgres 

/*resource "google_sql_database" "database" {
  name     = "postgres-test"
  instance = var.postgres-instance

  depends_on = [
      google_sql_database_instance.instance
  ]
}

resource "google_sql_database_instance" "instance" {
  name             = "my-test-instance"
  region           = "us-central1"
  database_version = "POSTGRES_15"
  deletion_protection = "true"
  settings {
    tier = "db-perf-optimized-N-4"
	edition = "ENTERPRISE_PLUS"
	availability_type = "REGIONAL"
	disk_type = "PD_SSD"
	disk_size = "250"
	ip_configuration {
      ipv4_enabled  = false
      private_network = var.network
      enable_private_path_for_google_cloud_services = true
	  }
	backup_configuration {
	  enabled = "true"
	  location = "us"
	  point_in_time_recovery_enabled = "true"
          transaction_log_retention_days = "14"
	  }
  }

}


resource "google_sql_user" "users" {
  name     = var.admin-user
  instance = var.postgres-instance
  password = var.admin-password

  depends_on = [
      google_sql_database_instance.instance
  ]

}*/

## Testing gcs bucket data source for cloud function 


/*data "google_storage_bucket" "my-bucket" {
  name = "test-bucketazedfqs"
}


resource "google_storage_bucket_object" "object2" {
  name   = "testcode"
  bucket = data.google_storage_bucket.my-bucket.name
  source = "function-source.zip"
}

resource "google_cloudfunctions2_function" "function" {
  name        = "function-test"
  location	  = "us-central1"
  description = "My function"
  
  build_config {
    runtime = "go121"
    entry_point = "SimExtract"  # Set the entry point 
    environment_variables = {
        DATABASE_URL = "postgres://postgres:dhOnoPu5HuwznnvV@db.nordcagpfxpthkwjwtvs.supabase.co:6543/postgres"
    }
    source {
      storage_source {
        bucket = data.google_storage_bucket.my-bucket.name
        object = google_storage_bucket_object.object2.name
      }
    }
  }
    service_config {
    max_instance_count  = 3
    min_instance_count = 1
    available_memory    = "4Gi"
    timeout_seconds     = 60
    max_instance_request_concurrency = 80
    available_cpu = "4"
    ingress_settings = "ALLOW_ALL"
    all_traffic_on_latest_revision = true
    service_account_email = var.serviceaccount
  }

  event_trigger {
    trigger_region = "us"
    event_type = "google.cloud.storage.object.v1.finalized"
    retry_policy = "RETRY_POLICY_RETRY"
    event_filters {
      attribute = "bucket"
      value = data.google_storage_bucket.my-bucket.name
    }
  }
}*/

#####################
## Internal Load balancer 
# proxy-only subnet
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "test-proxy-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = var.network
}

/*# backend subnet
resource "google_compute_subnetwork" "ilb_subnet" {
  name          = "default"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = var.network
}*/

# forwarding rule
/*resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "test-forwarding-rule"
  region                = "us-central1"
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80-80"
  target                = google_compute_region_target_http_proxy.default.id
  network               = var.network
  subnetwork            = var.subnet
}

# HTTP target proxy
resource "google_compute_region_target_http_proxy" "default" {
  name     = "test-http-proxy"
  region   = "us-central1"
  url_map  = google_compute_region_url_map.default.id
}

# URL map
resource "google_compute_region_url_map" "default" {
  name            = "test-loadbalancer"
  region          = "us-central1"
  default_service = google_compute_region_backend_service.default.id
}

# backend service
resource "google_compute_region_backend_service" "default" {
  name                  = "test-lb-backend"
  region                = "us-central1"
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.autohealing.id]
  backend {
    group           = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}*/

# instance template
/*resource "google_compute_instance_template" "instance_template" {
  name         = "test-lb-instance-template2"
  machine_type = "e2-small"
  tags         = ["http-server"]

  network_interface {
    network    = var.network
    subnetwork = var.subnet
    access_config {
      # add external ip to fetch packages
    }
  }
  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }

  # install nginx and serve a simple web page
  metadata_startup_script = <<EOF
      #! /bin/bash
      apt-get update
      apt-get install apache2
      EOF

  lifecycle {
    create_before_destroy = true
  }
}*/

# health check
/*resource "google_compute_region_health_check" "autohealing" {
  name     = "test-lb-healthcheck"
  region   = "us-central1"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3 # 50 seconds

  tcp_health_check {
    port = "80"
  }
  }

# MIG
resource "google_compute_region_instance_group_manager" "mig" {
  name     = "test-lb-mig"
  region   = "us-central1"
  named_port {
    name = "http"
    port = 80
  }
  version {
    instance_template = var.apache_template
    name              = "primary"
  }
  base_instance_name = "vm"
  target_size        = 2
  auto_healing_policies {
    health_check      = google_compute_region_health_check.autohealing.id
   initial_delay_sec = 300
  }
}
#Auto scaling policy

resource "google_compute_region_autoscaler" "scaler" {
  name   = "apache2-autoscaling"
  region = "us-central1"
  target = google_compute_region_instance_group_manager.mig.id

  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}



# allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw_iap" {
  name          = "test-lb-firewall"
  direction     = "INGRESS"
  network       = var.network
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "all"
  }
}

# allow http from proxy subnet to backends
resource "google_compute_firewall" "fw_ilb_to_backends" {
  name          = "test-firewall-to-backends"
  direction     = "INGRESS"
  network       = var.network
  source_ranges = ["10.0.0.0/24"]
  target_tags   = ["http-server"]
  allow {
    protocol = "all"
  }
}*/

##API , api config and api gateway

/*resource "google_api_gateway_api" "api" {
  provider = google-beta
  project = "bullitt-customer-portal"
  api_id = "mytest2-api"
  display_name = "test2-api"
}


resource "google_api_gateway_api_config" "api_cfg" {
  provider = google-beta
  project = "bullitt-customer-portal"
  api = google_api_gateway_api.api.api_id
  api_config_id = "mytest2-config"

  openapi_documents {
    document {
      path = "test3-cloudfunctions.yaml"
      contents = filebase64("test3-cloudfunctions.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api_gw" {
  provider = google-beta
  project = "bullitt-customer-portal"
  region = "us-central1"
  api_config = google_api_gateway_api_config.api_cfg.id
  gateway_id = "mytest2-gateway"
}

##Capturing api managed service url 


output "managed_service" {
	value =  google_api_gateway_api.api
}
resource "google_project_service" "project" {
  project = "bullitt-customer-portal"
  service = google_api_gateway_api.api.managed_service

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
  depends_on = [
      google_api_gateway_api.api, google_api_gateway_api_config.api_cfg
  ]
}

resource "google_apikeys_key" "api_key" {
  name         = "test2-apikey"
  display_name = "API key generated by Terraform"
  project      = "bullitt-customer-portal"
  provider     = google-beta

  restrictions {
    api_targets {
      service = google_api_gateway_api.api.managed_service
      methods = ["GET*"]
    }
  }
  depends_on = [google_api_gateway_api.api]
}*/

##Alloydb - postgres instance

resource "google_alloydb_instance" "default" {
  cluster       = google_alloydb_cluster.default.name
  instance_id   = "alloydb-instance"
  instance_type = "PRIMARY"

  machine_config {
    cpu_count = 2
  }
}


resource "google_alloydb_instance" "readpool" {
  cluster       = google_alloydb_cluster.default.name
  instance_id   = "alloyreadpool-instance"
  instance_type = "READ_POOL"
  
  read_pool_config {
   	node_count = 1 
  }
  machine_config {
    cpu_count = 2
  }
  depends_on = [
    google_alloydb_instance.default
  ]
}

resource "google_alloydb_cluster" "default" {
  cluster_id = "test2cluster"
  location   = "us-central1"
  network    = var.network

  initial_user {
    password = "alloydb@123"
  }
}

