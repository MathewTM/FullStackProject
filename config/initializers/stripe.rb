Rails.configuration.stripe = {
  publishable_key:  'pk_test_ndmfWZde93WLxuwrInvyKCXE',
  secret_key:       'sk_test_5QwD2asvXgMEQbkKsK7crk4U'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
