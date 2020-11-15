package tf.dynamodb

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.model.ListTagsOfResourceRequest;
import com.amazonaws.services.dynamodbv2.model.DescribeTimeToLiveRequest
import com.amazonaws.services.dynamodbv2.model.PointInTimeRecoveryDescription;
import com.amazonaws.services.dynamodbv2.model.DescribeContinuousBackupsRequest;

import com.deliveredtechnologies.terraform.api.TerraformApply
import com.deliveredtechnologies.terraform.api.TerraformDestroy
import com.deliveredtechnologies.terraform.api.TerraformInit
import com.deliveredtechnologies.terraform.api.TerraformOutput
import com.deliveredtechnologies.terraform.api.TerraformPlan
import groovy.json.JsonSlurper
import spock.lang.Specification

class DynamodbSpec extends Specification {

    def "Dynamodb module provisions a table in AWS"() {
        given:
            Properties tfProperties = new Properties()

            String region = 'us-east-2'
            String sys_id = "787"
			String app_sub_sys_id = "12345"
			String dynamodb_table_name = "spock_test"
			String environment = 'dev'
			String application_id = '12345'
			String created_by = 'Ravi'
			String date_class = 'yellow'
			String termination_date = 'n/a'
			String hash_key = 'id'
			String range_key = 'name'
			String ttl_enabled = true
			String ttl_attribute_name = 'id'
			String billing_mode = 'PROVISIONED'
			long write_capacity = '5'
			long read_capacity = '5' 
            String stackName = 'tf_examples'

            TerraformInit init = new TerraformInit(stackName)
            TerraformApply apply = new TerraformApply(stackName)

			AmazonDynamoDB ddb = AmazonDynamoDBClientBuilder.defaultClient();
			
            tfProperties.put('tfRootDir', stackName)
            //tfProperties.put('tfVars', 'table_name=my-table_name,hash_key=id,range_key=name,application_id=12345,environment=dev,created_by=Ravi,date_class=yellow,termination_date=n/a,stack_name=dynamo_db Table,sys_id=789,app_sub_sys_id=12345,attribute={id="N",name= \"S\"  }'.toString())
			tfProperties.put('tfVars', "table_name="+dynamodb_table_name+",hash_key="+hash_key+",range_key="+range_key+",application_id="+
				application_id+",environment="+environment+",created_by="+created_by+",date_class="+date_class+",termination_date="+termination_date+
				",stack_name="+stackName+",sys_id="+sys_id+",app_sub_sys_id="+app_sub_sys_id+",ttl_enabled="+ttl_enabled+",ttl_attribute_name="+
				ttl_attribute_name+",billing_mode="+billing_mode+",write_capacity="+write_capacity+",read_capacity="+read_capacity.toString())
        when:
            init.execute(tfProperties)
            apply.execute(tfProperties)
            def jsonOutput = getTerraformOutput(stackName)
            String table_name = jsonOutput?.dynamo_table_name?.value[0]
			String table_arn = jsonOutput?.dynamo_table_arn?.value[0]
			println "Table Name : ${table_name}"
			println "Table ARN : ${table_arn}"
			println "Table KMS ARN : ${ddb.describeTable(table_name)?.getTable()?.getSSEDescription()?.getKMSMasterKeyArn()}"
			println "Table SSE Type : ${ddb.describeTable(table_name)?.getTable()?.getSSEDescription()?.getSSEType()}"
			println "Table SSE Sttaus : ${ddb.describeTable(table_name)?.getTable()?.getSSEDescription()?.getStatus()}"
			println "Table Status : ${ddb.describeTable(table_name)?.getTable()?.getTableStatus()}"
			println "Table Stream Status : ${ddb.describeTable(table_name)?.getTable()?.getStreamSpecification()?.getStreamEnabled()}"
			println "TTL Status: ${ddb.describeTimeToLive(new DescribeTimeToLiveRequest().withTableName(table_name))?.getTimeToLiveDescription()?.getTimeToLiveStatus()}"
			println "Table tags : ${ddb.listTagsOfResource(new ListTagsOfResourceRequest().withResourceArn(table_arn))?.getTags()}"		
			println "Point In Time Recovery Status : ${ddb.describeContinuousBackups(new DescribeContinuousBackupsRequest().withTableName(table_name))?.getContinuousBackupsDescription()?.getPointInTimeRecoveryDescription()?.getPointInTimeRecoveryStatus()}"
						
        then:
			table_name.equals(sys_id+"_"+app_sub_sys_id+"_dyn_tab_"+dynamodb_table_name+"_"+environment)
			ddb.describeTable(table_name)?.getTable()?.getTableArn().equals(table_arn)
			ddb.describeTable(table_name)?.getTable()?.getSSEDescription()?.getSSEType()?.equals("KMS")
			ddb.describeTable(table_name)?.getTable()?.getSSEDescription()?.getStatus()?.equals("ENABLED")
			ddb.describeTable(table_name)?.getTable()?.getTableStatus()?.equals("ACTIVE")
			ddb.describeTable(table_name)?.getTable()?.getStreamSpecification()?.getStreamEnabled()?.equals(true)
			ddb.describeTable(table_name)?.getTable()?.getProvisionedThroughput()?.getWriteCapacityUnits()?.equals(write_capacity)
			ddb.describeTable(table_name)?.getTable()?.getProvisionedThroughput()?.getReadCapacityUnits()?.equals(read_capacity)
			ddb.describeContinuousBackups(new DescribeContinuousBackupsRequest().withTableName(table_name))?.getContinuousBackupsDescription()?.getPointInTimeRecoveryDescription()?.getPointInTimeRecoveryStatus()?.equals("ENABLED")
			ddb.describeTimeToLive(new DescribeTimeToLiveRequest().withTableName(table_name))?.getTimeToLiveDescription()?.getTimeToLiveStatus()?.equals("ENABLED")
			
        cleanup:
            TerraformDestroy destroy = new TerraformDestroy(stackName)
            destroy.execute(tfProperties)
    }

	private def getTerraformOutput(String stackName) {
		TerraformOutput output = new TerraformOutput(stackName)
		String tfOutput = output.execute(new Properties())
		JsonSlurper slurper = new JsonSlurper()
		println tfOutput
		slurper.parseText(tfOutput)
	}
}
