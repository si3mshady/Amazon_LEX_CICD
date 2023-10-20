# provider "aws" {
#   region = "us-east-1" # Set your desired AWS region
# }

# resource "aws_lex_bot" "restaurant_order_bot" {
#   name = "RestaurantOrderBotOne"
#   description = "Bot for Food Ordering"
#   create_version = false
#   locale = "en-US"

#   abort_statement {
#     message {
#       content_type = "PlainText"
#       content = "Sorry, I am not able to assist at this time"
#     }
#   }

#   child_directed = false

#   clarification_prompt {
#     max_attempts = 2
#     message {
#       content_type = "PlainText"
#       content = "I didn't understand you, what would you like to order?"
#     }
#   }

#   idle_session_ttl_in_seconds = 600
#   process_behavior = "BUILD"
#   voice_id = "Salli"

#   intent {
#     intent_name = aws_lex_intent.order_food.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.cancel_order.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.get_order_status.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.greeting.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.menu_inquiry.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.place_order.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.customize_order.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.confirm_order.name
#     intent_version = "$LATEST"
#   }

#   intent {
#     intent_name = aws_lex_intent.order_status_inquiry.name
#     intent_version = "$LATEST"
#   }

#   # intent {
#   #   intent_name = aws_lex_intent.cancel_order.name
#   #   intent_version = "$LATEST"
#   # }

#   intent {
#     intent_name = aws_lex_intent.farewell.name
#     intent_version = "$LATEST"
#   }
# }

# resource "aws_lex_slot_type" "menu" {
#   description = "Enumeration representing possible food items on the menu"
#   create_version = false

#   enumeration_value {
#     value = "burger"
#   }

#   enumeration_value {
#     value = "pizza"
#   }

#   enumeration_value {
#     value = "pasta"
#   }

#   enumeration_value {
#     value = "salad"
#   }

#   enumeration_value {
#     value = "sandwich"
#   }

#   enumeration_value {
#     value = "sushi"
#   }

#   name                     = "FoodItems"
#   value_selection_strategy = "ORIGINAL_VALUE"
# }

# resource "aws_lex_intent" "order_food" {
#   name = "OrderFood"
#   description = "Intent to order food from a restaurant"
#   create_version = false

#   sample_utterances = [
#     "I want to order food.",
#     "Can I get some food from your restaurant.",
#     "I'd like to place an order for delivery.",
#     "What's on the menu today.",
#     "How can I place an order for takeout.",
#     "I'm hungry. What can I order.",
#     "Do you have any specials for today.",
#     "I need to order some food for pickup.",
#     "Tell me about your food options.",
#     "I'm looking to get some food delivered."
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Sure, I can help you with that. Please provide the items you want to order and any specific instructions."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "OrderItems"
#     slot_type_version = "$LATEST"
#     description = "The items to be ordered"
#     priority = 1
#     slot_constraint = "Optional"
#     slot_type = aws_lex_slot_type.menu.name

#     sample_utterances = ["I want to order a {OrderItems}"]

#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "What items would you like to order? Please provide a list of items and any special requests."
#       }
#     }
#   }
# }

# # resource "aws_lex_intent" "cancel_order" {
# #   name = "CancelOrder"
# #   description = "Intent to cancel a food order"
# #   create_version = false

# #   sample_utterances = [
# #     "I want to cancel my order.",
# #     "Cancel my food order.",
# #     "I need to change my order.",
# #     "Can I modify my order."
# #   ]

# #   confirmation_prompt {
# #     max_attempts = 2

# #     message {
# #       content_type = "PlainText"
# #       content = "Of course, I can assist you with canceling your order. Please provide the order number or any relevant details."
# #     }
# #   }

# #   rejection_statement {
# #     message {
# #       content_type = "PlainText"
# #       content = "I'm sorry, I cannot assist you at this time."
# #     }
# #   }

# #   fulfillment_activity {
# #     type = "ReturnIntent"
# #   }

# #   slot {
# #     name = "OrderNumber"
# #     description = "The order number"
# #     priority = 1
# #     slot_constraint = "Required"
# #     slot_type = "AMAZON.NUMBER"

# #     sample_utterances = ["I want to cancel my order with order number {OrderNumber}"]

# #     value_elicitation_prompt {
# #       max_attempts = 2

# #       message {
# #         content_type = "PlainText"
# #         content = "Please provide your order number or relevant order details."
# #       }
# #     }
# #   }
# # }

# resource "aws_lex_intent" "get_order_status" {
#   name = "GetOrderStatus"
#   description = "Intent to retrieve order status"
#   create_version = false

#   sample_utterances = [
#     "Tell me about my order.",
#     "Give me details about my delivery.",
#     "I'd like to know the status of my delivery.",
#     "Check the status of my food order please.",
#     "Tell me about my recent order.",
#     "What's the status of my order {OrderNumber}",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "I can help you with that. Please provide your order number or your name, and I will retrieve your order status."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "OrderNumber"
#     description = "The order number"
#     priority = 1
#     slot_constraint = "Optional"
#     slot_type = "AMAZON.NUMBER"

#     sample_utterances = ["What's the status of my order {OrderNumber}"]

#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "Please provide your order number or your name."
#       }
#     }
#   }
# }

# resource "aws_lex_intent" "greeting" {
#   name = "Greeting"
#   description = "Handle initial greetings and set the context for the order"
#   create_version = false

#   sample_utterances = [
#     "Hello",
#     "Hi there",
#     "Good afternoon",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Hello! How can I assist you today?"
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }
# }

# resource "aws_lex_intent" "menu_inquiry" {
#   name = "MenuInquiry"
#   description = "Help users explore the menu and available food items"
#   create_version = false

#   sample_utterances = [
#     "What's on the menu?",
#     "Can you show me the menu?",
#     "Tell me about your food options.",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Sure, I can help you with that. Here's the menu. What would you like to order?"
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }
# }

# resource "aws_lex_intent" "place_order" {
#   name = "PlaceOrder"
#   description = "Allow users to place an order for food"
#   create_version = false

#   sample_utterances = [
#     "I'd like to order a pizza.",
#     "Can I get a burger, please?",
#     "I want to place an order for delivery.",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Great choice! Please provide the items you want to order and any specific instructions."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "OrderItems"
#     slot_type_version = "$LATEST"
#     description = "The items to be ordered"
#     priority = 1
#     slot_constraint = "Optional"
#     slot_type = aws_lex_slot_type.menu.name

#     sample_utterances = ["I want to order a {OrderItems}"]

#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "What items would you like to order? Please provide a list of items and any special requests."
#       }
#     }
#   }
# }

# resource "aws_lex_intent" "customize_order" {
#   name = "CustomizeOrder"
#   description = "Assist users in customizing their food order"
#   create_version = false

#   sample_utterances = [
#     "I want a large pepperoni pizza with extra cheese.",
#     "Can you make it a combo with fries and a drink?",
#     "I'm a vegetarian; can I get a veggie burger?",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Perfect! Please specify your customization and any additional details."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }
# }

# resource "aws_lex_intent" "confirm_order" {
#   name = "ConfirmOrder"
#   description = "Confirm the order details with the user"
#   create_version = false

#   sample_utterances = [
#     "Yes, that's correct.",
#     "Confirm my order.",
#     "That's what I want, proceed with the order.",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Great! Your order is confirmed."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }
# }

# resource "aws_lex_intent" "order_status_inquiry" {
#   name = "OrderStatusInquiry"
#   description = "Allow users to check the status of their placed orders"
#   create_version = false

#   sample_utterances = [
#     "Can you tell me the status of my order?",
#     "Where's my delivery?",
#     "When will my food arrive?",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Of course, I can assist you with that. Please provide your order number or your name, and I will retrieve your order status."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "OrderNumber"
#     description = "The order number"
#     priority = 1
#     slot_constraint = "Optional"
#     slot_type = "AMAZON.NUMBER"

#     sample_utterances = ["What's the status of my order {OrderNumber}"]

#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "Please provide your order number or your name."
#       }
#     }
#   }
# }

# resource "aws_lex_intent" "cancel_order" {
#   name = "CancelOrder"
#   description = "Handle order cancellation requests"
#   create_version = false

#   sample_utterances = [
#     "I need to cancel my order.",
#     "Cancel my food delivery.",
#     "I changed my mind; I want to cancel my order.",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Of course, I can assist you with canceling your order. Please provide the order number or any relevant details."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "OrderNumber"
#     description = "The order number"
#     priority = 1
#     slot_constraint = "Required"
#     slot_type = "AMAZON.NUMBER"

#     sample_utterances = ["I want to cancel my order with order number {OrderNumber}"]

#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "Please provide your order number or relevant order details."
#       }
#     }
#   }
# }

# resource "aws_lex_intent" "farewell" {
#   name = "Farewell"
#   description = "Provide a friendly farewell and conclude the conversation"
#   create_version = false

#   sample_utterances = [
#     "Goodbye",
#     "Thanks, bye!",
#     "See you later",
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Goodbye! If you have any more questions in the future, feel free to ask."
#     }
#   }

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }
# }
