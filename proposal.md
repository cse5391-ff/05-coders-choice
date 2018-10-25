Name: Jorge Valdez                             ID: 40382684

## Proposed Project
For my project, I plan to create a price and listings notifier for the Depop and
Grailed second-hand online clothing stores. From a web interface, users will be
able to track the price of a specific listing from one of these websites, or
they can track new listings for a given search query that appear on these sites.
They can then choose to receive notifications by email or text message according
to some frequency they specify.

To begin with, I plan on focusing on tracking search queries first, since that's
the API I've reverse engineered for these sites. Once that's complete, adding in
listings should follow the same process with a slight change in terms of data
output (one listing versus several). I just don't want to spend too much time
trying to parse the raw HTML or discovering the required endpoints since I want
to get the core tracking, refreshing, and process logic down first.

I've been wanting to create this for quite some time, and I have some basic
prototyping done in Node.JS, but to me Elixir seems like a better choice. Most
of my prototyping code has been reverse-engineering the APIs for these sites
(they're unprotected :wink:) along with some minute cleaning, but none of the
business logic has been implemented.

## Outline Structure
For the frontend, I of course plan to use Phoenix to provide some API as well as
serving a basic website to add and track listings.

For the backend, I will begin by implementing API clients for the two initial
sites I plan to crawl. These API clients will share a common interface and will
provide the logic used by a worker module.

Since users can choose to track a search query (and later, individual listings),
I plan on having a supervisor spawn a worker to pull and refresh the search
query results every _x_ amounts of time. As users add new things to track, the
supervisor can receive a message and start a new worker with the required
configurations and contextual information. Since the supervisor should be
stateless (save for what it already comes with by default), the processes will
contain their own state for tracking. The supervisor will not know about the
conditions, users, or even site that the worker processes will be tracking.

Every time a worker runs, the results of the new query should be sent back to
the supervisor and deferred to a model server, which will then handle mapping
the results of a search query to the internal representation needed to discover
new listings and price differentials. The model server will handle the results
processing for all of my worker processes, so it will be a GenServer with a
connection to a database.

As for the Phoenix application, it will only take care of sending a new track
request to the query process supervisor, and displaying information from the
model database. The Phoenix application may end up having it's own database for
the purpose of storing user-specific information as well as authentication, but
for the most part it will remain stateless.

I plan on structuring my project as an umbrella application, with apps for each
of my modules.
