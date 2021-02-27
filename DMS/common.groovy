def validateDmsDetails(dmsDetailsConfig) {
	try {
		println "DMS details config validation started"
		boolean valid = true
		List<String> errMsgs = new ArrayList<>()
		if(dmsDetailsConfig?.dms_vpc_id == null || dmsDetailsConfig?.dms_vpc_id == "") {
			errMsgs.add("\n\n dms_vpc_id value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_vpc_endpoint_service_name == null || dmsDetailsConfig?.dms_vpc_endpoint_service_name == "") {
			errMsgs.add("\n\n dms_vpc_endpoint_service_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_replication_subnet_group_name == null || dmsDetailsConfig?.dms_replication_subnet_group_name == "") {
			errMsgs.add("\n\n dms_replication_subnet_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_service_role_name == null || dmsDetailsConfig?.dms_service_role_name == "") {
			errMsgs.add("\n\n dms_service_role_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_service_role_managed_policy_name == null || dmsDetailsConfig?.dms_service_role_managed_policy_name == "") {
			errMsgs.add("\n\n dms_service_role_managed_policy_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_kinesis_access_application_role_name == null || dmsDetailsConfig?.dms_kinesis_access_application_role_name == "") {
			errMsgs.add("\n\n dms_kinesis_access_application_role_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_aurora_cluster_parameter_group_name == null || dmsDetailsConfig?.dms_aurora_cluster_parameter_group_name == "") {
			errMsgs.add("\n\n dms_aurora_cluster_parameter_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_aurora_instance_parameter_group_name == null || dmsDetailsConfig?.dms_aurora_instance_parameter_group_name == "") {
			errMsgs.add("\n\n dms_aurora_instance_parameter_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_vpc_security_group_name == null || dmsDetailsConfig?.dms_vpc_security_group_name == "") {
			errMsgs.add("\n\n dms_vpc_security_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_vpc_security_group_name_outbound_kinesis_endpoint == null || dmsDetailsConfig?.dms_vpc_security_group_name_outbound_kinesis_endpoint == "") {
			errMsgs.add("\n\n dms_vpc_security_group_name_outbound_kinesis_endpoint value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_vpc_security_group_name_outbound_sts_vpc_endpoint == null || dmsDetailsConfig?.dms_vpc_security_group_name_outbound_sts_vpc_endpoint == "") {
			errMsgs.add("\n\n dms_vpc_security_group_name_outbound_sts_vpc_endpoint value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_vpc_security_group_name_outbound_rds_endpoint == null || dmsDetailsConfig?.dms_vpc_security_group_name_outbound_rds_endpoint == "") {
			errMsgs.add("\n\n dms_vpc_security_group_name_outbound_rds_endpoint value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_kinesis_stream_private_endpoint_security_group_name == null || dmsDetailsConfig?.dms_kinesis_stream_private_endpoint_security_group_name == "") {
			errMsgs.add("\n\n dms_kinesis_stream_private_endpoint_security_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip == null || dmsDetailsConfig?.dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip == "") {
			errMsgs.add("\n\n dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_sts_private_endpoint_security_group_name == null || dmsDetailsConfig?.dms_sts_private_endpoint_security_group_name == "") {
			errMsgs.add("\n\n dms_sts_private_endpoint_security_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_sts_private_endpoint_security_group_dms_replication_instance_ip == null || dmsDetailsConfig?.dms_sts_private_endpoint_security_group_dms_replication_instance_ip == "") {
			errMsgs.add("\n\n dms_sts_private_endpoint_security_group_dms_replication_instance_ip value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_source_endpoint_rds_security_group_name == null || dmsDetailsConfig?.dms_source_endpoint_rds_security_group_name == "") {
			errMsgs.add("\n\n dms_source_endpoint_rds_security_group_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_source_endpoint_rds_security_group_dms_replication_instance_ip == null || dmsDetailsConfig?.dms_source_endpoint_rds_security_group_dms_replication_instance_ip == "") {
			errMsgs.add("\n\n dms_source_endpoint_rds_security_group_dms_replication_instance_ip value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_kinesis_stream_name == null || dmsDetailsConfig?.dms_kinesis_stream_name == "") {
			errMsgs.add("\n\n dms_kinesis_stream_name value is missing in dmsDetails in pipelineconfig.json")
			valid = false
		}
		if(dmsDetailsConfig?.dms_replication_instance_kms_key_id == null || dmsDetailsConfig?.dms_replication_instance_kms_key_id == "") {
			errMsgs.add("\n\n dms_replication_instance_kms_key_id value is missing in dmsDetails in pipelineconfig.json")
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

//3.1
def dmsVpcEndpointValidation(region, dms_vpc_endpoint_service_name){
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
//3.2
def dmsReplictaionSubnetGroupValidation(region, dms_replication_subnet_group_name, dms_vpc_id){
	try {
		def dms_replication_subnet_group_name_response
		dms_replication_subnet_group_name_response = sh returnStdout: true, script: "aws rds --region $region describe-db-subnet-groups --db-subnet-group-name $dms_replication_subnet_group_name"
		if(dms_replication_subnet_group_name_response?.DBSubnetGroups?.VpcId != $dms_vpc_id) {
			currentBuild.result = "ABORTED"
			error("DMS replication subner group name $dms_replication_subnet_group_name is not available in $region region VPC $dms_vpc_id")
		}
	}
	catch(err) {
		println "Error occured while validating dms_replication_subnet_group_name."
		throw err
	}
}
//3.3
def dmsServiceRoleValidation(dms_service_role_name, dms_service_role_managed_policy_name){
	try {
		def dms_service_role_name_exists
		dms_service_role_name_exists = sh returnStatus: true, script: "aws iam get-role --role-name $dms_service_role_name"
		if(dms_service_role_name_exists == 0) {
			def dms_service_role_managed_policy_name_response
			dms_service_role_managed_policy_name_response = sh returnStdout: true, script: "aws iam list-attached-role-policies --role-name $dms_service_role_name"
			if(!(dms_service_role_managed_policy_name_response?.AttachedPolicies?.PolicyName.contains($dms_service_role_managed_policy_name))) {
				currentBuild.result = "ABORTED"
				error("DMS managed policy role $dms_service_role_managed_policy_name is not available in $dms_service_role_name role")
			}
		}
		else {
			currentBuild.result = "ABORTED"
			error("DMS role $dms_service_role_name is not available")
		}
	}
	catch(err) {
		println "Error occured while validating dms_service_role_name."
		throw err
	}
}

//3.4
def dmsKinesisAccessApplicationRoleValidation(dms_kinesis_access_application_role_name){
	try {
		def dms_kinesis_access_application_role_name_exists
		dms_kinesis_access_application_role_name_exists = sh returnStatus: true, script: "aws iam get-role --role-name $dms_kinesis_access_application_role_name"
		if(dms_kinesis_access_application_role_name_exists != 0) {
			currentBuild.result = "ABORTED"
			error("DMS kinesis application access role name $dms_kinesis_access_application_role_name is not available")
		}
	}
	catch(err) {
		println "Error occured while validating dms_kinesis_access_application_role_name."
		throw err
	}
}



//3.5
def dmsAuroraClusterAndInstanceParametersValidation(region, dms_aurora_cluster_parameter_group_name, dms_aurora_instance_parameter_group_name){
	try {
		def dms_aurora_cluster_parameter_group_name_response
		dms_aurora_cluster_parameter_group_name_response = sh returnStdout: true, script: "aws rds --region $region describe-db-cluster-parameters --db-cluster-parameter-group-name $dms_aurora_cluster_parameter_group_name"
		if(dms_aurora_cluster_parameter_group_name_response?.Parameters?.ParameterValue[dms_aurora_cluster_parameter_group_name_response?.Parameters?.indexOf("rds_logical_replication")] != "on") {
			currentBuild.result = "ABORTED"
			error("DMS aurors cluster parameter group $dms_aurora_cluster_parameter_group_name not having parameter rds_logical_replication value as on")
		}
		if(dms_aurora_cluster_parameter_group_name_response?.Parameters?.ParameterValue[dms_aurora_cluster_parameter_group_name_response?.Parameters?.indexOf("wal_sender_timeout")] != "0") {
			currentBuild.result = "ABORTED"
			error("DMS aurors cluster parameter group $dms_aurora_cluster_parameter_group_name not having parameter wal_sender_timeout value as 0")
		}
		
		def dms_aurora_instance_parameter_group_name_response
		dms_aurora_instance_parameter_group_name_response = sh returnStdout: true, script: "aws rds --region $region describe-db-parameters --db-parameter-group-name $dms_aurora_instance_parameter_group_name"
		if(dms_aurora_cluster_parameter_group_name_response?.Parameters?.ParameterValue[dms_aurora_cluster_parameter_group_name_response?.Parameters?.indexOf("wal_level")] != "logical") {
			currentBuild.result = "ABORTED"
			error("DMS aurors instance parameter group $dms_aurora_instance_parameter_group_name not having parameter wal_level value as logical")
		}
		if(dms_aurora_cluster_parameter_group_name_response?.Parameters?.ParameterValue[dms_aurora_cluster_parameter_group_name_response?.Parameters?.indexOf("max_replication_slots")].toInteger() < 10) {
			currentBuild.result = "ABORTED"
			error("DMS aurors instance parameter group $dms_aurora_instance_parameter_group_name not having parameter max_replication_slots is less than 10")
		}
	}
	catch(err) {
		println "Error occured while validating dms_aurora_cluster_parameter_group_name and dms_aurora_instance_parameter_group_name."
		throw err
	}
}


//3.6.1 and 3.6.2
def dmsKinesisAccessApplicationRoleValidation(region, dms_vpc_security_group_name, dms_vpc_id, dms_vpc_security_group_name_outbound_kinesis_endpoint,
				dms_vpc_security_group_name_outbound_sts_vpc_endpointm, dms_vpc_security_group_name_outbound_rds_endpoint){
	try {
		def dms_vpc_security_group_name_response
		dms_vpc_security_group_name_response = sh returnStdout: true, script: "aws ec2 --region $region describe-security-groups --filters Name=vpc-id,Values=$dms_vpc_id Name=group-name,Values=$dms_vpc_security_group_name"
		if(dms_vpc_security_group_name_response?.SecurityGroups?.VpcId != $dms_vpc_id) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_vpc_security_group_name is not available in VPC $dms_vpc_id in region $region")
		}
		def flag = false
		// Check for dms_vpc_security_group_name_outbound_kinesis_endpoint
		for(index=0; index < dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress.size(); index++) {
			def IpPermissionsEgressObject = dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress[index]
			if(IpPermissionsEgressObject?.UserIdGroupPairs[0]?.GroupId == $dms_vpc_security_group_name_outbound_kinesis_endpoint &&
				IpPermissionsEgressObject?.FromPort == "443" && IpPermissionsEgressObject?.IpProtocol == "https" ) {
				flag = true
			}				
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_vpc_security_group_name doesn't have $dms_vpc_security_group_name_outbound_kinesis_endpoint outbound configured" )
		}
		flag = false
		// Check for dms_vpc_security_group_name_outbound_sts_vpc_endpoint
		for(index=0; index < dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress.size(); index++) {
			def IpPermissionsEgressObject = dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress[index]
			if(IpPermissionsEgressObject?.UserIdGroupPairs[0]?.GroupId == $dms_vpc_security_group_name_outbound_sts_vpc_endpoint &&
				IpPermissionsEgressObject?.FromPort == "443" && IpPermissionsEgressObject?.IpProtocol == "https" ) {
				flag = true
			}
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_vpc_security_group_name doesn't have $dms_vpc_security_group_name_outbound_sts_vpc_endpoint outbound configured" )
		}
		flag = false
		// Check for dms_vpc_security_group_name_outbound_rds_endpoint
		for(index=0; index < dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress.size(); index++) {
			def IpPermissionsEgressObject = dms_vpc_security_group_name_response.SecurityGroups[0].IpPermissionsEgress[index]
			if(IpPermissionsEgressObject?.UserIdGroupPairs[0]?.GroupId == $dms_vpc_security_group_name_outbound_rds_endpoint &&
				IpPermissionsEgressObject?.FromPort == "443" && IpPermissionsEgressObject?.IpProtocol == "https" ) {
				flag = true
			}
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_vpc_security_group_name doesn't have $dms_vpc_security_group_name_outbound_rds_endpoint outbound configured" )
		}
		
		
	}
	catch(err) {
		println "Error occured while validating dms_vpc_security_group_name."
		throw err
	}
	
}
//3.6.3
def dmsKinesisStreamPrivateEndpointSecurityGroupValidation(region, dms_kinesis_stream_private_endpoint_security_group_name, 
	dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip, dms_vpc_id){
	try {
		def dms_kinesis_stream_private_endpoint_security_group_name_response
		dms_kinesis_stream_private_endpoint_security_group_name_response = sh returnStdout: true, script: "aws ec2 --region $region describe-security-groups --filters Name=vpc-id,Values=$dms_vpc_id Name=group-name,Values=$dms_kinesis_stream_private_endpoint_security_group_name"
		def flag = false
		// Check for dms_kinesis_stream_private_endpoint_security_group_name
		for(index=0; index < dms_kinesis_stream_private_endpoint_security_group_name_response.SecurityGroups[0].IpPermissions.size(); index++) {
			def IpPermissionsObject = dms_kinesis_stream_private_endpoint_security_group_name_response.SecurityGroups[0].IpPermissions[index]
			if(IpPermissionsObject?.IpRanges[0]?.CidrIp == dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip &&
				IpPermissionsObject?.FromPort == "443" && IpPermissionsObject?.IpProtocol == "https" ) {
				flag = true
			}
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_kinesis_stream_private_endpoint_security_group_name doesn't have $dms_kinesis_stream_private_endpoint_security_group_dms_replication_instance_ip inbound configured" )
		}
	}
	catch(err) {
		println "Error occured while validating dms_kinesis_stream_private_endpoint_security_group_name."
		throw err
	}
}
//3.6.4
def dmsSTSPrivateEndpointSecurityGroupValidation(region, dms_sts_private_endpoint_security_group_name,
	dms_sts_private_endpoint_security_group_dms_replication_instance_ip, dms_vpc_id){
	try {
		def dms_sts_private_endpoint_security_group_name_response
		dms_sts_private_endpoint_security_group_name_response = sh returnStdout: true, script: "aws ec2 --region $region describe-security-groups --filters Name=vpc-id,Values=$dms_vpc_id Name=group-name,Values=$dms_sts_private_endpoint_security_group_name"
		def flag = false
		// Check for dms_sts_private_endpoint_security_group_name
		for(index=0; index < dms_sts_private_endpoint_security_group_name_response.SecurityGroups[0].IpPermissions.size(); index++) {
			def IpPermissionsObject = dms_sts_private_endpoint_security_group_name_response.SecurityGroups[0].IpPermissions[index]
			if(IpPermissionsObject?.IpRanges[0]?.CidrIp == dms_sts_private_endpoint_security_group_dms_replication_instance_ip &&
				IpPermissionsObject?.FromPort == "443" && IpPermissionsObject?.IpProtocol == "https" ) {
				flag = true
			}
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_sts_private_endpoint_security_group_name doesn't have $dms_sts_private_endpoint_security_group_dms_replication_instance_ip inbound configured" )
		}
	}
	catch(err) {
		println "Error occured while validating dms_sts_private_endpoint_security_group_name."
		throw err
	}
}
//3.6.5
def dmsSourceEndpointRdsSecurityGroupValidation(region, dms_source_endpoint_rds_security_group_name,
	dms_source_endpoint_rds_security_group_dms_replication_instance_ip, dms_vpc_id){
	try {
		def dms_source_endpoint_rds_security_group_name_response
		dms_source_endpoint_rds_security_group_name_response = sh returnStdout: true, script: "aws ec2 --region $region describe-security-groups --filters Name=vpc-id,Values=$dms_vpc_id Name=group-name,Values=$dms_source_endpoint_rds_security_group_name"
		def flag = false
		// Check for dms_source_endpoint_rds_security_group_name
		for(index=0; index < dms_source_endpoint_rds_security_group_name_response.SecurityGroups[0].IpPermissions.size(); index++) {
			def IpPermissionsObject = dms_source_endpoint_rds_security_group_name_response.SecurityGroups[0].IpPermissions[index]
			if(IpPermissionsObject?.UserIdGroupPairs[0]?.GroupId == dms_source_endpoint_rds_security_group_dms_replication_instance_ip &&
				IpPermissionsObject?.FromPort == "8443" && IpPermissionsObject?.IpProtocol == "tcp" ) {
				flag = true
			}
		}
		if(!flag) {
			currentBuild.result = "ABORTED"
			error("DMS security group $dms_source_endpoint_rds_security_group_name doesn't have $dms_source_endpoint_rds_security_group_dms_replication_instance_ip inbound configured" )
		}
	}
	catch(err) {
		println "Error occured while validating dms_source_endpoint_rds_security_group_name."
		throw err
	}
}
//3.7
def dmsKinesisAccessApplicationRoleValidation(region, dms_kinesis_stream_name){
	try {
		def dms_kinesis_stream_name_exists
		dms_kinesis_stream_name_exists = sh returnStatus: true, script: "aws kinesis --region $region describe-stream --stream-name $dms_kinesis_stream_name"
		if(dms_kinesis_stream_name_exists != 0) {
			currentBuild.result = "ABORTED"
			error("DMS kinesis stream $dms_kinesis_stream_name is not available")
		}
	}
	catch(err) {
		println "Error occured while validating dms_kinesis_stream_name."
		throw err
	}
}


//3.8
def dmsReplicationInstanceKmsKeyValidation(region, dms_replication_instance_kms_key_id){
	try {
		def dms_replication_instance_kms_key_id_exists
		dms_replication_instance_kms_key_id_exists = sh returnStatus: true, script: "aws kms --region $region describe-key --key-id $dms_replication_instance_kms_key_id"
		if(dms_replication_instance_kms_key_id_exists != 0) {
			currentBuild.result = "ABORTED"
			error("DMS replication instance KMS key $dms_replication_instance_kms_key_id is not available")
		}
	}
	catch(err) {
		println "Error occured while validating dms_replication_instance_kms_key_id."
		throw err
	}
}