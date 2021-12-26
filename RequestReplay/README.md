# RequestReplay

When making API changes,
it's nice to know that you won't affect current integrations.
To attempt to validate this, we'll build a tool to replay a
series of previously-captured API requests.

Here are a few JSON files containing a series of requests and responses from
the Stripe API. Each entry is a JSON map with the `request` entry describing
the HTTP request to send, and the `response` entry giving a sample response.

## Goal

Write a program which, given each of these files
(start with `requestlog-charges.json`),
replays each request to `api.stripe.com`
(see [this API docs](http://stripe.com/docs/api)),
and compares the real response to the request's sample response.
Since the responses we get from the API
have fields that vary (timestamps, IDs),
only check against the HTTP status code.
