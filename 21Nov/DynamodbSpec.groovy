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

			long write_capacity = 5
			long read_capacity = 5
            String stackName = 'tf-examples/dynamodb-bucket'
			String varFile = '../tfvars/dev.tfvars'

            TerraformInit init = new TerraformInit(stackName)
            TerraformApply apply = new TerraformApply(stackName)

			AmazonDynamoDB ddb = AmazonDynamoDBClientBuilder.defaultClient();
			
            tfProperties.put('tfRootDir', stackName)
			tfProperties.put('tfVarFiles', varFile)
			
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
