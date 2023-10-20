provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

resource "aws_lex_bot" "restaurant_order_bot" {
  name = "RestaurantOrderBotTwo"
  description = "Bot for Food Ordering"
  create_version = false
  locale = "en-US"

  abort_statement {
    message {
      content_type = "PlainText"
      content = "Sorry, I am not able to assist at this time"
    }
  }

  child_directed = false

  clarification_prompt {
    max_attempts = 2
    message {
      content_type = "PlainText"
      content = "I didn't understand you, what would you like to order"
    }
  }

  idle_session_ttl_in_seconds = 600
  process_behavior = "BUILD"
  voice_id = "Salli"

  intent {
    intent_name = aws_lex_intent.order_food.name
    intent_version = "$LATEST"
  }

  intent {
    intent_name = aws_lex_intent.cancel_order.name
    intent_version = "$LATEST"
  }

  intent {
    intent_name = aws_lex_intent.get_order_status.name
    intent_version = "$LATEST"
  }
}

resource "aws_lex_slot_type" "menu" {
  description = "Enumeration representing possible food items on the menu"
  create_version = false

  enumeration_value {
    value = "burger"
  }

  enumeration_value {
    value = "pizza"
  }

  enumeration_value {
    value = "pasta"
  }

  enumeration_value {
    value = "salad"
  }

  enumeration_value {
    value = "sandwich"
  }

  enumeration_value {
    value = "sushi"
  }

  name                     = "FoodItems"
  value_selection_strategy = "ORIGINAL_VALUE"
}

resource "aws_lex_intent" "order_food" {
  name = "OrderFood"
  description = "Intent to order food from a restaurant"
  create_version = false

  sample_utterances = [
    "I want to order food.",
    "Can I get some food from your restaurant.",
    "I'd like to place an order for delivery.",
    "What's on the menu today.",
    "How can I place an order for takeout.",
    "I'm hungry. What can I order.",
    "Do you have any specials for today.",
    "I need to order some food for pickup.",
    "Tell me about your food options.",
    "I'm looking to get some food delivered."
  ]

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "Absolutely, I'm thrilled to tell you about our delightful menu! Get ready for a mouthwatering experience with our incredible selection, including juicy burgers, heavenly pizzas, flavorful pastas, fresh and crisp salads, delectable sandwiches, and exquisite sushi."
      
    }
  }

  rejection_statement {
    message {
      content_type = "PlainText"
      content = "I'm sorry, I cannot assist you at this time."
    }
  }

  fulfillment_activity {
    type = "ReturnIntent"
  }

  slot {
    name = "OrderItems"
    slot_type_version = "$LATEST"
    description = "The items to be ordered"
    priority = 1
    slot_constraint = "Optional"
    slot_type = aws_lex_slot_type.menu.name

    sample_utterances = ["I want to order a {OrderItems}"]

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content_type = "PlainText"
        content = "What items would you like to order? Please provide a list of items and any special requests."
      }
    }
  }
}

resource "aws_lex_intent" "cancel_order" {
  name = "CancelOrder"
  description = "Intent to cancel a food order"
  create_version = false

  sample_utterances = [
    "I want to cancel my order.",
    "Cancel my food order.",
    "I need to change my order.",
    "Can I modify my order."
  ]

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "Of course, I can assist you with canceling your order. Please provide the order number or any relevant details."
    }
  }

  rejection_statement {
    message {
      content_type = "PlainText"
      content = "I'm sorry, I cannot assist you at this time."
    }
  }

  fulfillment_activity {
    type = "ReturnIntent"
  }

  slot {
    name = "OrderNumber"
    description = "The order number"
    priority = 1
    slot_constraint = "Required"
    slot_type = "AMAZON.NUMBER"

    sample_utterances = ["I want to cancel my order with order number {OrderNumber}"]

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content_type = "PlainText"
        content = "Please provide your order number or relevant order details."
      }
    }
  }
}

resource "aws_lex_intent" "get_order_status" {
  name = "GetOrderStatus"
  description = "Intent to retrieve order status"
  create_version = false

  sample_utterances = [
    "Tell me about my order.",
    "Give me details about my delivery.",
    "I'd like to know the status of my delivery.",
    "Check the status of my food order please.",
    "Tell me about my recent order.",
    "What's the status of my order {OrderNumber}",
  ]

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "I can help you with that. Please provide your order number or your name, and I will retrieve your order status."
    }
  }

  rejection_statement {
    message {
      content_type = "PlainText"
      content = "I'm sorry, I cannot assist you at this time."
    }
  }

  fulfillment_activity {
    type = "ReturnIntent"
  }

  slot {
    name = "OrderNumber"
    description = "The order number"
    priority = 1
    slot_constraint = "Optional"
    slot_type = "AMAZON.NUMBER"

    sample_utterances = ["What's the status of my order {OrderNumber}"]

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content_type = "PlainText"
        content = "Please provide your order number or your name."
      }
    }
  }
}
