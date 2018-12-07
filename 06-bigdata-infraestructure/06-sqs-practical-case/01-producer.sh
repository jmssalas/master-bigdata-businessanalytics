#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Params error. Run the script like this: ./01-producer.sh <sqs-profile> <messages-to-send> <queue-name>"
	exit 2
fi

# That profile have to be created on awscli
PROFILE=$1

# Set the amount of messages to send
let MESSAGES_TO_SEND=$2

# Set the queue name
QUEUE_NAME=$3


echo " ----------"
echo "| PRODUCER |"
echo " ----------"
echo ""


echo "Consulting if there is a queue with $QUEUE_NAME name..."
aws --profile $PROFILE sqs get-queue-url --queue-name $QUEUE_NAME
RESULT=`echo $?`
echo ""

if [ $RESULT -ne 0 ]
then
	echo "Creating a new queue..."

	# Create new queue
	MESSAGE=$(aws --profile $PROFILE sqs create-queue --queue-name $QUEUE_NAME --attributes {\"FifoQueue\":\"true\"})
	QUEUE_URL=$(echo $MESSAGE | jq -r '."QueueUrl"')
	echo "The queue url is: " $QUEUE_URL
	echo ""

else
	echo "There is a queue with $QUEUE_NAME name."
	MESSAGE=$(aws --profile $PROFILE sqs get-queue-url --queue-name $QUEUE_NAME)
	QUEUE_URL=$(echo $MESSAGE | jq -r '."QueueUrl"')
	echo "The queue url is: " $QUEUE_URL
	echo ""

	echo "Purging queue..."
	aws --profile $PROFILE sqs purge-queue --queue-url $QUEUE_URL
	echo "Queue purged"
	echo ""
fi

echo "Sending messages..."
for i in `seq 1 $MESSAGES_TO_SEND` 
do
	# Message text
	TEXT="Testing text number $i"

	# Send message to the queue
	aws --profile $PROFILE sqs send-message --queue-url $QUEUE_URL --message-body "$TEXT" --message-group-id 1 --message-deduplication-id $i
	
	echo "Message $i has been sent"
done

echo "All messages have been sent"
echo ""

echo "Getting amount of message from the queue..."
# Get number of messages
AMOUNT=$(aws --profile $PROFILE sqs get-queue-attributes --queue-url $QUEUE_URL --attribute-names "ApproximateNumberOfMessages" --query 'Attributes' --output text)
echo "Queue has $AMOUNT messages"

echo ""
echo "Exit the process"