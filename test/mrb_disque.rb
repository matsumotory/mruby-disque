##
## Disque Test
##

assert("Disque#addjob") do
  d = Disque.new
  job_id = d.addjob "q1", "box", "0"
  assert_not_equal(nil, job_id)
  d.deljob job_id
end

assert("Disque#getjob") do
  d = Disque.new
  d.addjob "q1", "box", "0"
  d.addjob "q1", "cat", "0"
  job1 = d.getjob "q1"
  job2 = d.getjob "q1"
  assert_equal("box", job1.job_name)
  assert_equal("cat", job2.job_name)
  d.deljob job1.job_id, job2.job_id
end

assert("Disque#run_command") do
  d = Disque.new
  job_id = d.addjob "q1", "box", "0"
  qlen = d.run_command :qlen, "q1"
  assert_equal(1, qlen)
  d.deljob job_id
end

