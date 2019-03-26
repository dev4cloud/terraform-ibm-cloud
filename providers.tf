variable ibm_bx_api_key {}
variable ibm_sl_username {}
variable ibm_sl_api_key {}

provider "ibm" {
    bluemix_api_key    = "${var.ibm_bx_api_key}"
    softlayer_username = "${var.ibm_sl_username}"
    softlayer_api_key  = "${var.ibm_sl_api_key}"
}
