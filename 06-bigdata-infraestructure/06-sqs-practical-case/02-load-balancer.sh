#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Params error. Run the script like this: ./01-producer.sh <sqs-profile> <queue-name>"
	exit 2
fi

# That profile have to be created on awscli
PROFILE=$1

# Set the queue name
QUEUE_NAME=$2


echo " ---------------"
echo "| LOAD BALANCER |"
echo " ---------------"
echo ""


echo "Consulting if there is a queue with $QUEUE_NAME name..."
aws --profile $PROFILE sqs get-queue-url --queue-name $QUEUE_NAME
RESULT=`echo $?`
echo ""

if [ $RESULT -ne 0 ]
then
	echo "Process error. There is no queue with $QUEUE_NAME name."
	exit 1

else
	echo "There is a queue with $QUEUE_NAME name."
	MESSAGE=$(aws --profile $PROFILE sqs get-queue-url --queue-name $QUEUE_NAME)
	QUEUE_URL=$(echo $MESSAGE | jq -r '."QueueUrl"')
	echo "The queue url is: " $QUEUE_URL
	echo ""
fi

let TOTAL_TIME=45
let SLEEP_TIME=15
let MAX_INSTANCES=5

for i in `seq 1 $SLEEP_TIME $TOTAL_TIME`
do
	echo "Getting amount of message from the queue..."
	# Get number of messages
	AMOUNT=$(aws --profile $PROFILE sqs get-queue-attributes --queue-url $QUEUE_URL --attribute-names "ApproximateNumberOfMessages" --query 'Attributes' --output text)
	echo "Queue has $AMOUNT messages"

	if [ $AMOUNT -ne 0 ]
	then 

		echo "Getting the active instances..."
		ACTIVE_INSTANCES=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].InstanceId' --output text)
		AMOUNT_ACTIVE_INSTANCES=$(echo $ACTIVE_INSTANCES | wc -l)
		echo "There is/are $AMOUNT_ACTIVE_INSTANCES active instance/s"
		echo ""

		echo "Getting machine's status..."
		let STATUS=$(expr $(expr $(expr $AMOUNT + 9)/10) - $AMOUNT_ACTIVE_INSTANCES)

		if [ $STATUS -lt 0 ]
		then
			echo "A instance has to be deleted"
			echo "Getting a instance..."
			INSTACE_TO_DELETE=$(echo $ACTIVE_INSTANCES | head -1)
			
			echo "Deleting the $INSTACE_TO_DELETE instance..."
			aws ec2 terminate-instances --instance-id $INSTACE_TO_DELETE
			echo "$INSTACE_TO_DELETE has been deleted"
		else
			if [ $AMOUNT_ACTIVE_INSTANCES -eq $MAX_INSTANCES ]
			then
				echo "Create a new instance is not possible. There are already $MAX_INSTANCES instances."
			else
				echo "Creating a new instance..."
				aws ec2 run-instances --image-id ami-09f0b8b3e41191524 --count 1 --instance-type t2.micro --key-name "MasterKey" --security-group-ids sg-015c48f6955832223 --subnet-id subnet-030f2245d3fd3c167 --instance-initiated-shutdown-behavior terminate --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=TestInstance}]'
				
				if [ `echo $?` -ne 0 ]
				then
					echo "There was a problem creating the new instance."
				else
					echo "A new instance has been created."
				fi
			fi
			
			echo ""
		fi
	else
		echo "There is no message in the queue."
		echo ""
	fi	
		echo "Sleeping $SLEEP_TIME seg..."
		sleep $SLEEP_TIME
		echo ""
done

echo ""
echo "Exit the process"
