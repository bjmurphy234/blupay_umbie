##
# BluePay Ruby Sample code.
#
# This code sample runs a $0.00 Credit Card Authorization.
# This stores the customer's payment information securely in
# BluePay to be used for further transactions.
##

require_relative "../../lib/bluepay.rb"

acct_id = "Merchant's Account ID Here"
sec_key = "Merchant's Secret Key Here"
trans_mode = "TEST" # Transaction Mode (can also be "LIVE")

payment = BluePay.new(
  account_id: acct_id,
  secret_key: sec_key,
  mode: trans_mode
)

payment.set_customer_information(
  first_name: "Bob", 
  last_name: "Tester",
  address1: "123 Test St.", 
  address2: "Apt #500", 
  city: "Testville", 
  state: "IL", 
  zip_code: "54321", 
  country: "USA",
  phone: "123-123-1234", 
  email: "test@bluepay.com"  
)

payment.set_cc_information(
  cc_number: "4111111111111111", # Customer Credit Card Number
  cc_expiration: "1215", # Card Expiration Date: MMYY
  cvv2: "123" # Card CVV2
)

payment.auth(amount: "0.00") # Card Authorization amount: $0.00

# Makes the API request with BluePay
payment.process

# If transaction was successful
if payment.successful_response?  
  # Reads the response from BluePay
  puts "TRANSACTION STATUS: " + payment.get_status
  puts "TRANSACTION MESSAGE: " + payment.get_message
  puts "TRANSACTION ID: " + payment.get_trans_id
  puts "AVS RESPONSE: " + payment.get_avs_code
  puts "CVV2 RESPONSE: " + payment.get_cvv2_code
  puts "MASKED PAYMENT ACCOUNT: " + payment.get_masked_account
  puts "CARD TYPE: " + payment.get_card_type
  puts "AUTH CODE: " + payment.get_auth_code
else
  puts payment.get_message
end
