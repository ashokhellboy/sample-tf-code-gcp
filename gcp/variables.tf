variable "cloud-run1" {

	description = "Image URL"
	type = string
	default = "cloudrun-test"

}	
variable "cloud-run2" {

	description = "Image URL"
	type = string
	default = "cloudrun-test2"

}	

variable "test-image" {

	description = "Image URL"
	type = string
	default = "us-docker.pkg.dev/cloudrun/container/hello"

}

variable "test-image2" {

	description = "Image URL"
	type = string
	default = "us-east1-docker.pkg.dev/bullitt-customer-portal/main/bsm-api:latest"

}

variable "serviceaccount" {

	description = "Image URL"
	type = string
	default = "1088629413996-compute@developer.gserviceaccount.com"

}

variable "objectpath" {

    description = "object path"
    type = string
    default = "test/function-source.zip"

}

variable "network" { 

    description = "network url" 
    type = string
    default = "projects/bullitt-customer-portal/global/networks/default"

}

variable "subnet" { 

    description = "sub-network url" 
    type = string
    default = "projects/bullitt-customer-portal/regions/us-central1/subnetworks/default"

}




variable "admin-user" {

    description = "Adding a admin user"
    type = string
    default = "admin"

}

variable "admin-password" {

    description = "Adding a admin user"
    type = string
    default = "admin@123"

}


variable "secret-data" {

    description = "Adding a admin user"
    type = string
    default = "https://test-url.com"

}

variable "postgres-instance" {

    description = "Adding a admin user"
    type = string
    default = "my-test-instance"

}
### Adding variables for Load balancer


variable "region" {
  description = "All resources will be launched in this region."
  type        = string
  default     = "us-central1"
}

variable "name" {
  description = "Name for the load balancer forwarding rule and prefix for supporting resources."
  type        = string
  default     = "test-loadbalancer"
}

variable "ports" {
  description = "List of ports (or port ranges) to forward to backend services. Max is 5."
  type        = list(string)
  default     = ["8081","8082","8085"]
}

variable "health_check_port" {
  description = "Port to perform health checks on."
  type        = number
  default     = "443"
}

variable "backends" {
  description = "List of backends, should be a map of key-value pairs for each backend, must have the 'group' key."
  type        = list(map(string))
  # Example
  # backends = [
  #   { 
  #     description = "Sample Instance Group for Internal LB",
  #     group       = "The fully-qualified URL of an Instance Group"
  #   }   
  # ]
  default = [
    
    {

      protocol    = "HTTP"
      port_name   = "http"
      enable_cdn  = "false"
  } 
  ] 
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# These variables have defaults, but may be overridden by the operator.
# ---------------------------------------------------------------------------------------------------------------------

/*variable "network" {
  description = "Self link of the VPC network in which to deploy the resources."
  type        = string
  default     = "default"
}*/

variable "subnetwork" {
  description = "Self link of the VPC subnetwork in which to deploy the resources."
  type        = string
  default     = "default"
}

variable "protocol" {
  description = "The protocol for the backend and frontend forwarding rule. TCP or UDP."
  type        = string
  default     = "TCP"
}

variable "ip_address" {
  description = "IP address of the load balancer. If empty, an IP address will be automatically assigned."
  type        = string
  default     = null
}

variable "service_label" {
  description = "An optional prefix to the service name for this Forwarding Rule. If specified, will be the first label of the fully qualified service name."
  type        = string
  default     = ""
}

variable "network_project" {
  description = "The name of the GCP Project where the network is located. Useful when using networks shared between projects. If empty, var.project will be used."
  type        = string
  default     = ""
}

variable "http_health_check" {
  description = "Set to true if health check is type http, otherwise health check is tcp."
  type        = bool
  default     = false
}

variable "session_affinity" {
  description = "The session affinity for the backends, e.g.: NONE, CLIENT_IP. Default is `NONE`."
  type        = string
  default     = "NONE"
}

variable "source_tags" {
  description = "List of source tags for traffic between the internal load balancer."
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "List of target tags for traffic between the internal load balancer."
  type        = list(string)
  default     = []
}

variable "custom_labels" {
  description = "A map of custom labels to apply to the resources. The key is the label name and the value is the label value."
  type        = map(string)
  default     = {}
}

variable "apache_template" {
  description = "Apache2 template URL"
  type        = string
  default     = "projects/bullitt-customer-portal/regions/us-central1/instanceTemplates/apache2-template"
}

variable "mig_group" {
  description = "Managed instance group URL"
  type        = string
  default     = "projects/bullitt-customer-portal/regions/us-central1/instanceGroups/test-lb-mig"
}

## variable for api_config

/*variable "openapi_template_vars" {
  type = object({
    project_name    = string
    backend_address = string
  })
}*/