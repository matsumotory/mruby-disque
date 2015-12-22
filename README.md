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
```ruby
assert("Disque#addjob") do
  d = Disque.new
  job_id = d.addjob "q1", "box", "0"
  assert_not_equal(nil, job_id)
  d.deljob job_id.to_s
end

assert("Disque#getjob") do
  d = Disque.new
  d.addjob "q1", "box", "0"
  d.addjob "q1", "cat", "0"
  job1 = d.getjob "q1"
  job2 = d.getjob "q1"
  assert_equal("box", job1[0][2])
  assert_equal("cat", job2[0][2])
  d.deljob job1[0][1], job2[0][1]
end

assert("Disque#run_command") do
  d = Disque.new
  job_id = d.addjob "q1", "box", "0"
  qlen = d.run_command :qlen, "q1"
  assert_equal(1, qlen)
  d.deljob job_id.to_s
end
```

## License
under the MIT License:
- see LICENSE file
