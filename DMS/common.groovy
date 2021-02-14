def validateDmsDetails(dmsDetailsConfig) {
	try {
		println "DMS details config validation started"
		boolean valid = true
		List<String> errMsgs = new ArrayList<>()
		if(dmsDetailsConfig?.dms_vpc_endpoint_service_name == null || dmsDetailsConfig?.dms_vpc_endpoint_service_name == "") {
			errMsgs.add("\n\n dms_vpc_endpoint_service_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(!valid) {
			currentBuild.result = "ABORTED"
			error("Error occured while validating the dmsDetails config values. Error details: ${errMsgs}")
		}
	}
	catch(err) {
		shared_lib.info("Error occured while validating the dmsDetails config values.")
		throw err
	}
}

def dmsVpcEndpointvalidation(region, dms_vpc_endpoint_service_name){
	try {
		def dms_vpc_endpoint_service_name_exists
		dms_vpc_endpoint_service_name_exists = sh returnStatus: true, script: "aws ec2 --region $region describe-vpc-endpoints --service-name $dms_vpc_endpoint_service_name"
		if(dms_vpc_endpoint_service_name_exists != 0) {
			currentBuild.result = "ABORTED"
			error("DMS VPC enpoint $dms_vpc_endpoint_service_name is not available in $region region")			
		}
	}
	catch(err) {
		println "Error occured while validating dms_vpc_endpoint_service_name."
		throw err
	}
}

