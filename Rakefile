#!/usr/bin/env rake
require "bundler/gem_tasks"

task :test do
  Dir['test/*_test.rb'].each do |testfile|
    load testfile
  end
end
