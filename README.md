# mruby-disque   [![Build Status](https://travis-ci.org/matsumoto-r/mruby-disque.png?branch=master)](https://travis-ci.org/matsumoto-r/mruby-disque)
[Disque](https://github.com/antirez/disque) client class

## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

  # ... (snip) ...

  conf.gem :mgem => 'mruby-disque'
end
```
## example

Install [Disque](https://github.com/antirez/disque) and start `./disque/src/disque-server`

```ruby
assert("Disque#addjob") do
  d = Disque.new
  job_id = d.addjob "q1", "box"
  assert_not_equal(nil, job_id)
  d.deljob job_id
end

assert("Disque#getjob") do
  d = Disque.new
  d.addjob "q1", "box"
  d.addjob "q1", "cat"
  job1 = d.getjob "q1"
  job2 = d.getjob "q1"
  assert_equal("box", job1.job_name)
  assert_equal("cat", job2.job_name)
  d.deljob job1.job_id, job2.job_id
end

assert("Disque#run_command") do
  d = Disque.new
  job_id = d.addjob "q1", "box"
  qlen = d.run_command :qlen, "q1"
  assert_equal(1, qlen)
  d.deljob job_id
end
```

## License
under the MIT License:
- see LICENSE file
