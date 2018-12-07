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


echo " ----------"
echo "| CONSUMER |"
echo " ----------"
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

let TOTAL_TIME=600
let SLEEP_TIME=6

for i in `seq 1 $SLEEP_TIME $TOTAL_TIME`
do
	echo "Getting a message..."
	# Get message from the queue
	MESSAGE=$(aws --profile $PROFILE sqs receive-message --queue-url $QUEUE_URL --visibility-timeout 30)

	if [ "$MESSAGE" != "" ]
	then 
		echo "A message has been got"
		echo ""

		# Get the receipt handle from the message
		RECEIPT_HANDLE=$(echo $MESSAGE | jq '.Messages[] | ."ReceiptHandle"')
		BODY=$(echo $MESSAGE | jq '.Messages[] | ."Body"')

		echo "The message's body is:"
		# Print the message
		echo $BODY
		echo ""

		echo "The message's receipt handle is:"
		echo $RECEIPT_HANDLE
		echo ""

		echo "Deleting the message..."
		# Delete the message
		echo $RECEIPT_HANDLE | xargs aws --profile $PROFILE sqs delete-message --queue-url $QUEUE_URL --receipt-handle
		echo "Message has been deleted"
		echo ""

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