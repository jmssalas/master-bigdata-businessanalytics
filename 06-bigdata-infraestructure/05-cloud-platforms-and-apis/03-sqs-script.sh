#!/bin/bash

# That profile have to be created on awscli
PROFILE="sqs"

# Message text
TEXT="Testing text"

# Create new queue
MESSAGE=$(aws --profile $PROFILE sqs create-queue --queue-name masterfifoqueue.fifo --attributes {\"FifoQueue\":\"true\"})
QUEUE_URL=$(echo $MESSAGE | jq -r '."QueueUrl"')
echo $QUEUE_URL

# Send message to the queue
aws --profile $PROFILE sqs send-message --queue-url $QUEUE_URL --message-body "$TEXT" --message-group-id 1 --message-deduplication-id 1

# Get message from the queue
MESSAGE=$(aws --profile $PROFILE sqs receive-message --queue-url $QUEUE_URL --visibility-timeout 30 --wait-time-seconds 20)

# Get the receipt handle from the message
RECEIPT_HANDLE=$(echo $MESSAGE | jq '.Messages[] | ."ReceiptHandle"')

# Print the message
echo $MESSAGE
echo $RECEIPT_HANDLE

# Delete the message
echo $RECEIPT_HANDLE | xargs aws --profile $PROFILE sqs delete-message --queue-url $QUEUE_URL --receipt-handle

# Get number of messages
aws --profile $PROFILE sqs get-queue-attributes --queue-url $QUEUE_URL --attribute-names "ApproximateNumberOfMessages" --query 'Attributes' --output text

# Delete queue
aws --profile $PROFILE sqs delete-queue --queue-url $QUEUE_URL 