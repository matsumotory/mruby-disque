##
## Disque Test
##

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

