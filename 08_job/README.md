# JOB AND CRONJOB

# JOB
A job creates one or more pods and ensures that a specified number of them successfully terminate.
As pods successfully complete, the job tracks the successful completions.
When a specified number of successful completions is reached, the job itself is complete.
Deleting a Job will cleanup the pods it created.

* kubectl create -f parallel-job.yml


# CRONJOB
A Cron Job manages time based Jobs, namely:
    - Once at a specified point in time
    - Repeatedly at a specified point in time
One CronJob object is like one line of a crontab (cron table) file. It runs a job periodically on a given schedule, written in Cron format.

* kubectl create -f cron-job.yml
