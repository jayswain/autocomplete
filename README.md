# Autocomplete problem

This is my solution to a fun autocomplete problem.

## Run it

`ruby autocomplete.rb text/shakespeare-complete.txt`

## Original problem description

Create a Ruby library that can autocomplete word fragments using a text file as the data source.

* You should be able to index the autocomplete-able words from any text file (feel free to ignore non-word entities like numbers)
* When returning the list of autocompleted words for a word fragment, it should order the words by their frequency (most frequent first)
* It should also return the frequency of each word as part of the results
* It should return no more than 25 results for any word fragment
* Use the provided complete works of Shakespeare and include your results for the following fragments: th, fr, pi, sh, wu, ar, il, ne, se, pl

There are various decisions and minor differences that go into different solutions, so don't worry about precise results matching up with our own – we're not going to evaluate it like that. Also, I'm not going to give you specific class/module structure since I think these decisions are part of the problem. We'll be evaluating your solution based on your approach to the problem (algorithm), readability/maintainability/style, and performance characteristics. Only include any tests if it helps you, we won't penalize or judge you for not having them.

It isn't timed, but please don't spend more than a few hours on it as we don't want to take up too much of your time.

NOTE: You must use pure Ruby - no third-party gems, data stores, etc. However, feel free to use any reference resources, just make sure to cite anything you use (aside from the obvious Ruby docs, etc).
