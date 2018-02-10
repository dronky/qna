# README

This README would normally document whatever steps are necessary to get the
application up and running.

Sidekiq start: `sidekiq -q default -q mailers`  
Sphinx make indexing: `rake ts:index`
Sphinx global search `ThinkingSphinx.search 'swafaw'`

* Ruby version: ruby-2.4.1

* Database: postgres

* Services: 
  * job queue: sidekiq, ActiveJob
  * search engine: sphinx
